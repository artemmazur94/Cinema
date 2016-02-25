using System;

namespace Cinema.Web.Models
{
    public class TicketViewModel
    {
        public int Id { get; set; }

        public string MovieName { get; set; }

        public string HallName { get; set; }

        public int Type { get; set; }

        public int Row { get; set; }

        public int Place { get; set; }

        public decimal Price { get; set; }

        public DateTime Date { get; set; }

        public TimeSpan Time { get; set; }
    }
}