using System;
using System.Linq;
using Cinema.DataAccess.Repositories.Contracts;

namespace Cinema.DataAccess.Repositories
{
    public class SecurityTokenRepository : GenericRepositrory<SecurityToken>, ISecurityTokenRepository
    {
        private CinemaDatabaseEntities _securityTokenRepository => _context;

        public SecurityTokenRepository(CinemaDatabaseEntities context) :base(context)
        {
        }

        public string GetUsernameByToken(Guid token)
        {
            DateTime datetime = DateTime.UtcNow.AddDays(-1);
            var securityToken = _securityTokenRepository.SecurityTokens.FirstOrDefault
                (
                    x => x.Id == token &&
                         x.ResetRequestDateTime > datetime &&
                         x.IsUsed == false
                );
            return securityToken?.Account.Login;
        }
    }
}