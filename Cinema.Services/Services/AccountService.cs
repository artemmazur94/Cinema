using System;
using System.Linq;
using Cinema.DataAccess;
using Cinema.Services.Contracts;
using Cinema.Services.Helpers;

namespace Cinema.Services
{
    public class AccountService : IAccountService
    {
        private readonly IUnitOfWork _unitOfWork;

        public AccountService(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public void Commit()
        {
            _unitOfWork.Commit();
        }

        public void CreatePassword(Account account)
        {
            CreatePassword(account, account.Password);
        }

        private void CreatePassword(Account account, string password)
        {
            account.Salt = PasswordManager.GenerateSalt(16);
            account.Password = PasswordManager.GenerateSaltedPassword(password, account.Salt);
        }

        public bool IsValidLoginData(Account account)
        {
            string salt = _unitOfWork.AccountRepository.GetAccountByUsername(account.Login).Salt;
            account.Password = PasswordManager.GenerateSaltedPassword(account.Password, salt);
            return _unitOfWork.AccountRepository.IsValidLoginData(account);
        }

        public bool IsExistUsername(string username)
        {
            return _unitOfWork.AccountRepository.IsExistUsername(username);
        }

        public bool IsExistEmail(string email)
        {
            return _unitOfWork.AccountRepository.IsExistEmail(email);
        }

        public void RestorePassword(string email, string restoreDomain)
        {
            var account = _unitOfWork.AccountRepository.Find(x => x.Email == email).First();
            var guid = Guid.NewGuid();
            _unitOfWork.AccountRepository.AddSecurityToken(new SecurityToken()
            {
                AccountId = account.Id,
                Id = guid,
                ResetRequestDateTime = DateTime.UtcNow
            });
            var restoreUrl = CombineRestoreUrl(restoreDomain, guid.ToString());
            EmailManager.RestorePasswordEmail(restoreUrl, email, account.Login);
        }

        private string CombineRestoreUrl(string domain, string token)
        {
            return "http://" + domain + "/Account/UpdatePassword?token=" + token;
        }

        public string GetUsernameByToken(Guid token)
        {
            return _unitOfWork.SecurityTokenRepository.GetUsernameByToken(token);
        }

        public void UpdatePassword(string username, string password)
        {
            var account = _unitOfWork.AccountRepository.Find(x => x.Login == username).First();
            account.Password = PasswordManager.GenerateSaltedPassword(password, account.Salt);
            _unitOfWork.AccountRepository.Update(account);
        }

        public void UseSecurityToken(Guid token)
        {
            var securityToken = _unitOfWork.SecurityTokenRepository.Find(x => x.Id == token).First();
            securityToken.IsUsed = true;
            _unitOfWork.SecurityTokenRepository.Update(securityToken);
        }

        public void ChangePassword(string login, string newPassword)
        {
            Account account = _unitOfWork.AccountRepository.GetAccountByUsername(login);
            CreatePassword(account, newPassword);
        }

        public Profile GetProfileByUsername(string username)
        {
            return _unitOfWork.AccountRepository.GetAccountByUsername(username).Profile.First();
        }

        public Account GetAccountByUsername(string username)
        {
            return _unitOfWork.AccountRepository.GetAccountByUsername(username);
        }

        public void AddProfile(Profile profile)
        {
            _unitOfWork.AccountRepository.AddProfile(profile);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (disposing)
            {
                _unitOfWork.Dispose();
            }
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}