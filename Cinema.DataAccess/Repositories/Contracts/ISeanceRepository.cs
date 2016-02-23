﻿using System;
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

        List<TicketPreOrder> GetSeanceTicketPreOrdersOfCurUser(int seanceId, int accountId);

        bool IsBindedToOtherAccount(int row, int place, int seanceId, int accountId);

        bool IsBindedByCurrnetUser(int row, int place, int seanceId, int accountId);

        TicketPreOrder GetBySeanceData(int row, int place, int seanceId, int accountId);

        void DeleteTicketPreOrder(TicketPreOrder ticketPreOrder);

        void RemoveTicketPreOrdersForUser(int seanceId, int accountId);

        void AddTickets(List<Ticket> tickets);
    }
}