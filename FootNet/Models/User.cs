using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace FootNet.Models
{
    public partial class User
    {
        public User()
        {
            Bills = new HashSet<Bill>();
            UserSelectedServices = new HashSet<UserSelectedService>();
            Vouchers = new HashSet<Voucher>();
        }

        public string Userid { get; set; } = null!;
        public string? Username { get; set; }
        public string? Password { get; set; }
        public string? Email { get; set; }
        public string? Phoneno { get; set; }
        public int? Pointbefore { get; set; }
        public int? Pointtrans { get; set; }
        public int? Pointafter { get; set; }
        public bool? Isadmin { get; set; }

        public virtual ICollection<Bill> Bills { get; set; }
        public virtual ICollection<UserSelectedService> UserSelectedServices { get; set; }

        public virtual ICollection<Voucher> Vouchers { get; set; }
    }
}
   
