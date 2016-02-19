using System;
using System.Collections.Generic;

namespace Cinema.DataAccess.Repositories.Contracts
{
    public interface ISeanceRepository : IDisposable, IRepository<Seance>
    {
    }
}