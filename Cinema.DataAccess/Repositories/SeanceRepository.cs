using System.Collections.Generic;
using System.Linq;
using Cinema.DataAccess.Repositories.Contracts;

namespace Cinema.DataAccess.Repositories
{
    public class SeanceRepository : GenericRepositrory<Seance>, ISeanceRepository
    {
        private CinemaDatabaseEntities _seanceContext => _context;

        public SeanceRepository(CinemaDatabaseEntities context) : base(context)
        {
        }

        public List<Sector> GetSectorsByHallId(int hallId)
        {
            return _seanceContext.Sectors.Where(x => x.HallId == hallId).ToList();
        }
    }
}