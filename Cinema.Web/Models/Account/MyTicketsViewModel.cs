using System.Collections.Generic;

namespace Cinema.Web.Models
{
    public class MyTicketsViewModel
    {
        public List<TicketViewModel> UsedTickets { get; set; }

        public List<TicketViewModel> UnusedTickets { get; set; }
    }
}