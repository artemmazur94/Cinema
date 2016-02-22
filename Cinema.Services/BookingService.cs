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

        public Seance GetSeance(int id)
        {
            return _seanceRepository.Get(id);
        }

        public List<Sector> GetSectorsByHallId(int hallId)
        {
            return _seanceRepository.GetSectorsByHallId(hallId);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (!_disposed)
            {
                if (disposing)
                {
                    _seanceRepository.Dispose();
                }
            }
            _disposed = true;
        }

        public bool IsAbleToBook(int row, int place, int seanceId)
        {
            if (_seanceRepository.IsExistTicketPreOrder(row, place, seanceId) || 
                _seanceRepository.IsExistTicket(row, place, seanceId))
            {
                return false;
            }
            return true;
        }

        public void Dispose()
        {
            Dispose(true);
        }
    }
}