using System;
using System.Collections.Generic;
using System.Data.Entity;
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

        public List<TicketPreOrder> GetSeanceTicketPreOrdersOfCurUser(int seanceId, int accountId)
        {
            return
                _seanceContext.TicketPreOrders.Where( x => 
                        x.SeanceId == seanceId && 
                        !x.IsDeleted && 
                        x.AccountId == accountId).ToList();
        }

        public bool IsBindedToOtherAccount(int row, int place, int seanceId, int accountId)
        {
            return
                _seanceContext.TicketPreOrders.FirstOrDefault( x => 
                        x.SeanceId == seanceId && 
                        x.Place == place && 
                        x.Row == row && 
                        !x.IsDeleted &&
                        x.AccountId != accountId) != null;
        }

        public bool IsBindedByCurrnetUser(int row, int place, int seanceId, int accountId)
        {
            return
                _seanceContext.TicketPreOrders.FirstOrDefault( x => 
                        x.AccountId == accountId && 
                        x.SeanceId == seanceId && 
                        x.Row == row && 
                        !x.IsDeleted &&
                        x.Place == place) != null;
        }

        public TicketPreOrder GetBySeanceData(int row, int place, int seanceId, int accountId)
        {
            return
                _seanceContext.TicketPreOrders.FirstOrDefault( x => 
                        x.Row == row && 
                        x.Place == place && 
                        x.SeanceId == seanceId && 
                        !x.IsDeleted &&
                        x.AccountId == accountId);
        }

        public void DeleteTicketPreOrder(TicketPreOrder ticketPreOrder)
        {
            _seanceContext.TicketPreOrders.Remove(ticketPreOrder);
        }

        public void RemoveTicketPreOrdersForUser(int seanceId, int accountId)
        {
            List<TicketPreOrder> ticketPreOrders =
                _seanceContext.TicketPreOrders.Where( x => 
                        x.AccountId == accountId && 
                        x.SeanceId == seanceId && 
                        !x.IsDeleted).ToList();
            ticketPreOrders.ForEach(x => x.IsDeleted = true);
        }
    }
}