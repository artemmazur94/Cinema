using System;
using Cinema.DataAccess;

namespace Cinema.Services.Contracts
{
    public interface IAccountService: IDisposable
    {
        void Commit();

        void CreatePassword(Account account);

        bool IsValidLoginData(Account account);

        bool IsExistUsername(string username);

        bool IsExistEmail(string email);

        void RestorePassword(string email, string restoreDomain);

        string GetUsernameByToken(Guid token);

        void UpdatePassword(string username, string password);

        void UseSecurityToken(Guid token);

        void ChangePassword(string login, string newPassword);

        Profile GetProfileByUsername(string username);

        Account GetAccountByUsername(string username);

        void AddProfile(Profile profile);
    }
}