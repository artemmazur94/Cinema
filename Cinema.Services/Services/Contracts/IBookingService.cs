using System;
using System.Collections.Generic;
using Cinema.DataAccess;

namespace Cinema.Services.Contracts
{
    public interface IBookingService : IDisposable
    {
        void Commit();

        List<Seance> GetActiveSeancesByMovieId(int movieId);

        Seance GetSeance(int id);

        List<Sector> GetSectorsByHallId(int hallId);

        bool IsTicketAbleToBook(int row, int place, int seanceId);

        void AddTicketPreOrder(TicketPreOrder ticketPreOrder);

        List<Ticket> GetSeanceTickets(int seanceId);

        List<TicketPreOrder> GetSeanceTicketPreOrdersOfOtherUsers(int seanceId, int accountId);

        List<TicketPreOrder> GetSeanceTicketPreOrdersForCurrentUser(int seanceId, int accountId);

        bool IsSeatBindedToOtherUser(int row, int place, int seanceId, int accountId);

        bool IsSeatBindedByCurrnetUser(int row, int place, int seanceId, int accountId);

        void RemoveTicketPreOrderForUser(int row, int place, int seeanceId, int accountId);

        void MarkTicketPreOrdersAsDeletedForUser(int seanceId, int accountId);

        void AddTickets(List<Ticket> tickets);

        void RemoveTicketPreOrdersForUser(int seanceId, int accountId);

        List<Ticket> GetTicketsForUser(int accountId);

        int GetSeatType(int hallId, int row, int place);

        List<Hall> GetAllHalls();
    }
}