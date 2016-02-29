using System;
using System.Linq;
using Cinema.DataAccess.Repositories.Contracts;

namespace Cinema.DataAccess.Repositories
{
    public class AccountRepository : GenericRepositrory<Account>, IAccountRepository
    {
        private CinemaDatabaseEntities _accountContext => _context;

        public AccountRepository(CinemaDatabaseEntities context) : base(context)
        {
        }

        public bool IsExistUsername(string username)
        {
            return _accountContext.Accounts.FirstOrDefault(x => x.Login.Equals(username, StringComparison.CurrentCulture)) != null;
        }

        public bool IsExistEmail(string email)
        {
            return _accountContext.Accounts.FirstOrDefault(x => x.Email == email) != null;
        }

        public bool IsValidLoginData(Account account)
        {
            return
                _accountContext.Accounts.FirstOrDefault(x => 
                x.Login == account.Login && 
                x.Password == account.Password) != null;
        }

        public void AddSecurityToken(SecurityToken securityToken)
        {
            _accountContext.SecurityTokens.Add(securityToken);
        }

        public Account GetAccountByUsername(string username)
        {
            return _accountContext.Accounts.Single(x => x.Login == username);
        }

        public void AddProfile(Profile profile)
        {
            _accountContext.Profiles.Add(profile);
        }
    }
}