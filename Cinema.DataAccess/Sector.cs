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
    
    public partial class Sector
    {
        public int Id { get; set; }
        public int FromRow { get; set; }
        public int ToRow { get; set; }
        public int FromPlace { get; set; }
        public int ToPlace { get; set; }
        public int SectorTypeId { get; set; }
        public int HallId { get; set; }
    
        public virtual SectorType SectorType { get; set; }
        public virtual Hall Hall { get; set; }
    }
}
