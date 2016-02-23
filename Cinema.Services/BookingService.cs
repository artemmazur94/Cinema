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

        public void Save()
        {
            _seanceRepository.Save();
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
            if (_seanceRepository.IsExistTicket(row, place, seanceId))
            {
                return false;
            }
            return true;
        }

        public void AddTicketPreOrder(TicketPreOrder ticketPreOrder)
        {
            _seanceRepository.AddTicketPreOrder(ticketPreOrder);
        }

        public List<Ticket> GetSeanceTickets(int seanceId)
        {
            return _seanceRepository.GetSeanceTickets(seanceId);
        }

        public List<TicketPreOrder> GetSeanceTicketPreOrdersOfOtherUsers(int seanceId, int accountId)
        {
            return _seanceRepository.GetSeanceTicketPreOrdersOfOtherUsers(seanceId, accountId);
        }

        public List<TicketPreOrder> GetSeanceTicketPreOrdersOfCurUser(int seanceId, int accountId)
        {
            return _seanceRepository.GetSeanceTicketPreOrdersOfCurUser(seanceId, accountId);
        }

        public bool IsBindedToOtherAccount(int row, int place, int seanceId, int accountId)
        {
            return _seanceRepository.IsBindedToOtherAccount(row, place, seanceId, accountId);
        }

        public bool IsBindedByCurrnetUser(int row, int place, int seanceId, int accountId)
        {
            return _seanceRepository.IsBindedByCurrnetUser(row, place, seanceId, accountId);
        }

        public void DeleteTicketPreOrder(int row, int place, int seanceId, int accountId)
        {
            TicketPreOrder ticketPreOrder = _seanceRepository.GetBySeanceData(row, place, seanceId, accountId);
            _seanceRepository.DeleteTicketPreOrder(ticketPreOrder);
        }

        public void RemoveTicketPreOrdersForUser(int seanceId, int accountId)
        {
            _seanceRepository.RemoveTicketPreOrdersForUser(seanceId, accountId);
        }

        public void Dispose()
        {
            Dispose(true);
        }
    }
}