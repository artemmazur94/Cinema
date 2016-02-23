using System.Collections.Generic;
using System.Linq;
using Cinema.DataAccess;

namespace Cinema.Web.Models
{
    public class HallSeat
    {
        public int Row { get; set; }
        
        public int Place { get; set; }

        public int Type { get; set; }

        public static List<HallSeat> GetAllSeats(List<Ticket> seanceTickets, List<TicketPreOrder> seanceTicketPreOrders)
        {
            List<HallSeat> seats = (from seanceTicket in seanceTickets
                select new HallSeat()
                {
                    Row = seanceTicket.Row,
                    Place = seanceTicket.Place 
                }).ToList();
            seats.AddRange((from seanceTicketPreOrder in seanceTicketPreOrders
                select new HallSeat()
                {
                    Row = seanceTicketPreOrder.Row,
                    Place = seanceTicketPreOrder.Place
                }).Distinct());
            return seats;
        }

        public static List<HallSeat> GetAllSeats(List<TicketPreOrder> seanceTicketPreOrders)
        {
            return (from seanceTicketPreOrder in seanceTicketPreOrders
                select new HallSeat()
                {
                    Row = seanceTicketPreOrder.Row,
                    Place = seanceTicketPreOrder.Place
                }).ToList();
        }

        public static void SetSeatTypes(List<HallSeat> selectedSeats, List<Sector> sectors)
        {
            selectedSeats.ForEach( x =>
                    x.Type =
                        sectors.First( z =>
                                x.Row >= z.FromRow && 
                                x.Row <= z.ToRow && 
                                x.Place >= z.FromPlace && 
                                x.Place <= z.ToPlace)
                            .SectorType.Id);
        }
    }
}