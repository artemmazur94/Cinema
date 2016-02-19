using System.Collections.Generic;
using Cinema.DataAccess.Repositories.Contracts;

namespace Cinema.DataAccess.Repositories
{
    public class SeanceRepository : GenericRepositrory<Seance>, ISeanceRepository
    {
        private CinemaDatabaseEntities _seanceContext => _context;

        public SeanceRepository(CinemaDatabaseEntities context) : base(context)
        {
        }

    }
}