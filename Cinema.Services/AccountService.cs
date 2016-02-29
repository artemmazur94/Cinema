﻿using System;
using System.Linq;
using Cinema.DataAccess;
using Cinema.DataAccess.Repositories.Contracts;
using Cinema.Services.Helpers;

namespace Cinema.Services
{
    public class AccountService : IDisposable
    {
        private readonly IAccountRepository _accountRepository;
        private readonly ISecurityTokenRepository _securityTokenRepository;

        private bool _disposed;

        public AccountService(IAccountRepository accountRepository, ISecurityTokenRepository securityTokenRepository)
        {
            _accountRepository = accountRepository;
            _securityTokenRepository = securityTokenRepository;
        }

        public void Save()
        {
            _accountRepository.Save();
            _securityTokenRepository.Save();
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
            string salt = _accountRepository.GetAccountByUsername(account.Login).Salt;
            account.Password = PasswordManager.GenerateSaltedPassword(account.Password, salt);
            return _accountRepository.IsValidLoginData(account);
        }

        public bool IsExistUsername(string username)
        {
            return _accountRepository.IsExistUsername(username);
        }

        public bool IsExistEmail(string email)
        {
            return _accountRepository.IsExistEmail(email);
        }

        public void RestorePassword(string email, string restoreDomain)
        {
            var account = _accountRepository.Find(x => x.Email == email).First();
            var guid = Guid.NewGuid();
            _accountRepository.AddSecurityToken(new SecurityToken()
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
            return _securityTokenRepository.GetUsernameByToken(token);
        }

        public void UpdatePassword(string username, string password)
        {
            var account = _accountRepository.Find(x => x.Login == username).First();
            account.Password = PasswordManager.GenerateSaltedPassword(password, account.Salt);
            _accountRepository.Update(account);
        }

        public void UseSecurityToken(Guid token)
        {
            var securityToken = _securityTokenRepository.Find(x => x.Id == token).First();
            securityToken.IsUsed = true;
            _securityTokenRepository.Update(securityToken);
        }

        public void ChangePassword(string login, string newPassword)
        {
            Account account = _accountRepository.GetAccountByUsername(login);
            CreatePassword(account, newPassword);
        }

        public Profile GetProfileByUserName(string username)
        {
            return _accountRepository.GetAccountByUsername(username).Profile.First();
        }

        public Account GetAccountByUserName(string username)
        {
            return _accountRepository.GetAccountByUsername(username);
        }

        public void AddProfile(Profile profile)
        {
            _accountRepository.AddProfile(profile);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!_disposed)
            {
                if (disposing)
                {
                    _accountRepository.Dispose();
                    _securityTokenRepository.Dispose();
                }
            }
            _disposed = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}