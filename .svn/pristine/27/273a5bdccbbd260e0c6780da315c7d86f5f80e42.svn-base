using System;
using System.Collections.Generic;
using System.Linq;
using Cinema.DataAccess;
using Cinema.DataAccess.Repositories.Contracts;

namespace Cinema.Services
{
    public class BookingService : IDisposable
    {
        private readonly ISeanceRepository _seanceRepository;

        private bool _disposed;

        public BookingService(ISeanceRepository seanceRepository)
        {
            _seanceRepository = seanceRepository;
        }

        public List<Seance> GetActiveSeancesByMovieId(int movieId)
        {
            return _seanceRepository.Find(x => x.MovieId == movieId && x.DateTime > DateTime.UtcNow).ToList();
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!_disposed)
            {
                if (disposing)
                {
                    
                }
            }
            _disposed = true;
        }

        public void Dispose()
        {
            Dispose(true);
        }
    }
}