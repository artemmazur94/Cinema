using System;
using System.ComponentModel.DataAnnotations;
using System.Web;

namespace Cinema.Web.Models
{
    public class ProfileViewModel
    {
        public int Id { get; set; }

        [Required]
        [Display(Name = "Name: ")]
        public string Name { get; set; }

        [Required]
        [Display(Name = "Surname: ")]
        public string Surname { get; set; }

        [Display(Name = "Phone: ")]
        [DataType(DataType.PhoneNumber)]
        public string Phone { get; set; }

        [Display(Name = "Photo: ")]
        public HttpPostedFileBase Photo { get; set; }

        public byte[] ImageBytes { get; set; }
    }
}