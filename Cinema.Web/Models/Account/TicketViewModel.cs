namespace Cinema.Web.Models
{
    public class TicketViewModel
    {
        public int Id { get; set; }

        public string MovieName { get; set; }

        public int Type { get; set; }

        public int Row { get; set; }

        public int Place { get; set; }

        public decimal Price { get; set; }
    }
}