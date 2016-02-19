using System;

namespace Cinema.DataAccess.Repositories.Contracts
{
    public interface IAccountRepository : IDisposable, IRepository<Account>
    {
        bool IsExistUsername(string username);

        bool IsExistEmail(string email);

        bool IsValidLoginData(Account account);

        void AddSecurityToken(SecurityToken securityToken);

        Account GetAccountByUsername(string username);

        void AddProfile(Profile profile);
    }
}