using System;
using System.Collections.Generic;
using System.Linq;
using Cinema.DataAccess;
using Cinema.Services.Contracts;

namespace Cinema.Services
{
    public class BookingService : IBookingService
    {
        private readonly IUnitOfWork _unitOfWork;

        public BookingService(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public void Commit()
        {
            _unitOfWork.Commit();
        }

        public List<Seance> GetActiveSeancesByMovieId(int movieId)
        {
            return _unitOfWork.SeanceRepository.Find(x => x.MovieId == movieId && x.DateTime > DateTime.UtcNow).ToList();
        }

        public Seance GetSeance(int id)
        {
            return _unitOfWork.SeanceRepository.Get(id);
        }

        public List<Sector> GetSectorsByHallId(int hallId)
        {
            return _unitOfWork.SeanceRepository.GetSectorsByHallId(hallId);
        }

        public bool IsTicketAbleToBook(int row, int place, int seanceId)
        {
            return !_unitOfWork.SeanceRepository.IsExistTicket(row, place, seanceId);
        }

        public void AddTicketPreOrder(TicketPreOrder ticketPreOrder)
        {
            _unitOfWork.SeanceRepository.AddTicketPreOrder(ticketPreOrder);
        }

        public List<Ticket> GetSeanceTickets(int seanceId)
        {
            return _unitOfWork.SeanceRepository.GetSeanceTickets(seanceId);
        }

        public List<TicketPreOrder> GetSeanceTicketPreOrdersOfOtherUsers(int seanceId, int accountId)
        {
            return _unitOfWork.SeanceRepository.GetSeanceTicketPreOrdersOfOtherUsers(seanceId, accountId);
        }

        public List<TicketPreOrder> GetSeanceTicketPreOrdersForCurrentUser(int seanceId, int accountId)
        {
            return _unitOfWork.SeanceRepository.GetSeanceTicketPreOrdersForUser(seanceId, accountId);
        }

        public bool IsSeatBindedToOtherUser(int row, int place, int seanceId, int accountId)
        {
            return _unitOfWork.SeanceRepository.IsSeatBindedToOtherUser(row, place, seanceId, accountId);
        }

        public bool IsSeatBindedByCurrnetUser(int row, int place, int seanceId, int accountId)
        {
            return _unitOfWork.SeanceRepository.IsSeatBindedByCurrnetUser(row, place, seanceId, accountId);
        }

        public void RemoveTicketPreOrderForUser(int row, int place, int seanceId, int accountId)
        {
            TicketPreOrder ticketPreOrder = _unitOfWork.SeanceRepository.GetTicketPreOrderBySeanceData(row, place, seanceId, accountId);
            _unitOfWork.SeanceRepository.RemoveTicketPreOrder(ticketPreOrder);
        }

        public void MarkTicketPreOrdersAsDeletedForUser(int seanceId, int accountId)
        {
            _unitOfWork.SeanceRepository.MarkSeanceTicketPreOrdersAsDeletedForUser(seanceId, accountId);
        }

        public void AddTickets(List<Ticket> tickets)
        {
            _unitOfWork.SeanceRepository.AddTickets(tickets);
        }

        public void RemoveTicketPreOrdersForUser(int seanceId, int accountId)
        {
            List<TicketPreOrder> ticketPreOrders = GetSeanceTicketPreOrdersForCurrentUser(seanceId, accountId);
            ticketPreOrders.ForEach(x => _unitOfWork.SeanceRepository.RemoveTicketPreOrder(x));
        }

        public List<Ticket> GetTicketsForUser(int accountId)
        {
            return _unitOfWork.SeanceRepository.GetTicketsForUser(accountId);
        }

        public int GetSeatType(int hallId, int row, int place)
        {
            return _unitOfWork.SeanceRepository.GetSeatType(hallId, row, place);
        }

        public List<Hall> GetAllHalls()
        {
            return _unitOfWork.SeanceRepository.GetAllHalls();
        }

        protected virtual void Dispose(bool disposing)
        {
            if (disposing)
            {
                _unitOfWork.Dispose();
            }
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}