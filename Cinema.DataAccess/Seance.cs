//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Cinema.DataAccess
{
    using System;
    using System.Collections.Generic;
    
    public partial class Seance
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Seance()
        {
            this.Tickets = new HashSet<Ticket>();
            this.TicketPreOrders = new HashSet<TicketPreOrder>();
        }
    
        public int Id { get; set; }
        public decimal Price { get; set; }
        public System.DateTime DateTime { get; set; }
        public int HallId { get; set; }
        public int MovieId { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Ticket> Tickets { get; set; }
        public virtual Hall Hall { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<TicketPreOrder> TicketPreOrders { get; set; }
        public virtual Movie Movy { get; set; }
    }
}
