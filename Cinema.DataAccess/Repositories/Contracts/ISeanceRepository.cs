using System;
using System.Collections.Generic;

namespace Cinema.DataAccess.Repositories.Contracts
{
    public interface ISeanceRepository : IDisposable, IRepository<Seance>
    {
        List<Sector> GetSectorsByHallId(int hallId);

        bool IsExistTicketPreOrder(int row, int place, int seanceId);

        bool IsExistTicket(int row, int place, int seanceId);

        void AddTicketPreOrder(TicketPreOrder ticketPreOrder);

        List<Ticket> GetSeanceTickets(int seanceId);

        List<TicketPreOrder> GetSeanceTicketPreOrdersOfOtherUsers(int seanceId, int accountId);

        List<TicketPreOrder> GetSeanceTicketPreOrdersForUser(int seanceId, int accountId);

        bool IsSeatBindedToOtherUser(int row, int place, int seanceId, int accountId);

        bool IsSeatBindedByCurrnetUser(int row, int place, int seanceId, int accountId);

        TicketPreOrder GetTicketPreOrderBySeanceData(int row, int place, int seanceId, int accountId);

        void RemoveTicketPreOrder(TicketPreOrder ticketPreOrder);

        void MarkSeanceTicketPreOrdersAsDeletedForUser(int seanceId, int accountId);

        void AddTickets(List<Ticket> tickets);

        List<Ticket> GetTicketsForUser(int accountId);

        int GetSeatType(int hallId, int row, int place);

        List<Hall> GetAllHalls();
    }
}