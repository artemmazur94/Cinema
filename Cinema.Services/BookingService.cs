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

        public bool IsTicketAbleToBook(int row, int place, int seanceId)
        {
            return !_seanceRepository.IsExistTicket(row, place, seanceId);
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

        public List<TicketPreOrder> GetSeanceTicketPreOrdersForCurrentUser(int seanceId, int accountId)
        {
            return _seanceRepository.GetSeanceTicketPreOrdersForUser(seanceId, accountId);
        }

        public bool IsSeatBindedToOtherUser(int row, int place, int seanceId, int accountId)
        {
            return _seanceRepository.IsSeatBindedToOtherUser(row, place, seanceId, accountId);
        }

        public bool IsSeatBindedByCurrnetUser(int row, int place, int seanceId, int accountId)
        {
            return _seanceRepository.IsSeatBindedByCurrnetUser(row, place, seanceId, accountId);
        }

        public void RemoveTicketPreOrderForUser(int row, int place, int seanceId, int accountId)
        {
            TicketPreOrder ticketPreOrder = _seanceRepository.GetTicketPreOrderBySeanceData(row, place, seanceId, accountId);
            _seanceRepository.RemoveTicketPreOrder(ticketPreOrder);
        }

        public void MarkTicketPreOrdersAsDeletedForUser(int seanceId, int accountId)
        {
            _seanceRepository.MarkSeanceTicketPreOrdersAsDeletedForUser(seanceId, accountId);
        }

        public void AddTickets(List<Ticket> tickets)
        {
            _seanceRepository.AddTickets(tickets);
        }

        public void RemoveTicketPreOrdersForUser(int seanceId, int accountId)
        {
            List<TicketPreOrder> ticketPreOrders = GetSeanceTicketPreOrdersForCurrentUser(seanceId, accountId);
            ticketPreOrders.ForEach(x => _seanceRepository.RemoveTicketPreOrder(x));
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

        public List<Ticket> GetTicketsForUser(int accountId)
        {
            return _seanceRepository.GetTicketsForUser(accountId);
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}