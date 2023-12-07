using System;
using System.Collections.Generic;

namespace Admin_Baocao.Models
{
    public partial class Bill
    {
        public Bill()
        {
            BillSelectedFnbs = new HashSet<BillSelectedFnb>();
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
        public virtual ICollection<BillSelectedFnb> BillSelectedFnbs { get; set; }
    }
}
