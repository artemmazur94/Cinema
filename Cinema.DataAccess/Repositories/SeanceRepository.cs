﻿using System.Collections.Generic;
using System.Linq;
using Cinema.DataAccess.Repositories.Contracts;

namespace Cinema.DataAccess.Repositories
{
    public class SeanceRepository : GenericRepositrory<Seance>, ISeanceRepository
    {
        private CinemaDatabaseEntities _seanceContext => _context;

        public SeanceRepository(CinemaDatabaseEntities context) : base(context)
        {
        }

        public List<Sector> GetSectorsByHallId(int hallId)
        {
            return _seanceContext.Sectors.Where(x => x.HallId == hallId).ToList();
        }

        public bool IsExistTicketPreOrder(int row, int place, int seanceId)
        {
            return
                _seanceContext.TicketPreOrders.FirstOrDefault(x => 
                    x.Place == place && 
                    x.Row == row && 
                    x.SeanceId == seanceId) != null;
        }

        public bool IsExistTicket(int row, int place, int seanceId)
        {
            return
                _seanceContext.Tickets.FirstOrDefault(x => 
                    x.Place == place && 
                    x.Row == row && 
                    x.SeanceId == seanceId) != null;
        }

        public void AddTicketPreOrder(TicketPreOrder ticketPreOrder)
        {
            _seanceContext.TicketPreOrders.Add(ticketPreOrder);
        }

        public List<Ticket> GetSeanceTickets(int seanceId)
        {
            return _seanceContext.Tickets.Where(x => x.SeanceId == seanceId).ToList();
        }

        public List<TicketPreOrder> GetSeanceTicketPreOrdersOfOtherUsers(int seanceId, int accountId)
        {
            return
                _seanceContext.TicketPreOrders.Where( x =>
                        x.SeanceId == seanceId &&
                        !x.IsDeleted &&
                        x.AccountId != accountId).ToList();
        }

        public List<TicketPreOrder> GetSeanceTicketPreOrdersForUser(int seanceId, int accountId)
        {
            return
                _seanceContext.TicketPreOrders.Where( x => 
                        x.SeanceId == seanceId && 
                        !x.IsDeleted && 
                        x.AccountId == accountId).ToList();
        }

        public bool IsSeatBindedToOtherUser(int row, int place, int seanceId, int accountId)
        {
            return
                _seanceContext.TicketPreOrders.FirstOrDefault( x => 
                        x.SeanceId == seanceId && 
                        x.Place == place && 
                        x.Row == row && 
                        !x.IsDeleted &&
                        x.AccountId != accountId) != null;
        }

        public bool IsSeatBindedByCurrnetUser(int row, int place, int seanceId, int accountId)
        {
            return
                _seanceContext.TicketPreOrders.FirstOrDefault( x => 
                        x.AccountId == accountId && 
                        x.SeanceId == seanceId && 
                        x.Row == row && 
                        !x.IsDeleted &&
                        x.Place == place) != null;
        }

        public TicketPreOrder GetTicketPreOrderBySeanceData(int row, int place, int seanceId, int accountId)
        {
            return
                _seanceContext.TicketPreOrders.FirstOrDefault( x => 
                        x.Row == row && 
                        x.Place == place && 
                        x.SeanceId == seanceId && 
                        !x.IsDeleted &&
                        x.AccountId == accountId);
        }

        public void RemoveTicketPreOrder(TicketPreOrder ticketPreOrder)
        {
            _seanceContext.TicketPreOrders.Remove(ticketPreOrder);
        }

        public void MarkSeanceTicketPreOrdersAsDeletedForUser(int seanceId, int accountId)
        {
            List<TicketPreOrder> ticketPreOrders = GetSeanceTicketPreOrdersForUser(seanceId, accountId);
            ticketPreOrders.ForEach(x => x.IsDeleted = true);
        }

        public void AddTickets(List<Ticket> tickets)
        {
            _seanceContext.Tickets.AddRange(tickets);
        }
    }
}