using System;
using System.Collections.Generic;

namespace Cinema.DataAccess.Repositories.Contracts
{
    public interface ISeanceRepository : IDisposable, IRepository<Seance>
    {
        List<Sector> GetSectorsByHallId(int hallId);

        bool IsExistTicketPreOrder(int row, int place, int seanceId);

        bool IsExistTicket(int row, int place, int seanceId);
    }
}