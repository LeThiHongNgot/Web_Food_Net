using System;
using System.Collections.Generic;

namespace FootNet.Models
{
    public partial class Bill
    {
        public Bill()
        {
            Fnbs = new HashSet<Fnb>();
        }

        public string Billno { get; set; } = null!;
        public string Userid { get; set; } = null!;
        public string? Voucherid { get; set; }
        public DateTime? Daytime { get; set; }
        public string? Description { get; set; }
        public int? Amountno { get; set; }
        public double? Total { get; set; }

        public virtual User User { get; set; } = null!;
        public virtual Voucher? Voucher { get; set; }

        public virtual ICollection<Fnb> Fnbs { get; set; }
    }
}
