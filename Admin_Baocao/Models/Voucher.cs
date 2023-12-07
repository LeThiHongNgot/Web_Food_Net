using System;
using System.Collections.Generic;

namespace Admin_Baocao.Models
{
    public partial class Voucher
    {
        public Voucher()
        {
            Bills = new HashSet<Bill>();
            Users = new HashSet<User>();
        }

        public string Voucherid { get; set; } = null!;
        public string? Vouchername { get; set; }
        public int? Discount { get; set; }
        public string? Description { get; set; }
        public string? Status { get; set; }
        public int? Pointvoucher { get; set; }

        public virtual ICollection<Bill> Bills { get; set; }

        public virtual ICollection<User> Users { get; set; }
    }
}
