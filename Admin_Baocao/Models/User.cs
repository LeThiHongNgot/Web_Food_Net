using System;
using System.Collections.Generic;

namespace Admin_Baocao.Models
{
    public partial class User
    {
        public User()
        {
            Bills = new HashSet<Bill>();
            Services = new HashSet<Service>();
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

        public virtual ICollection<Service> Services { get; set; }
        public virtual ICollection<Voucher> Vouchers { get; set; }
    }
}
