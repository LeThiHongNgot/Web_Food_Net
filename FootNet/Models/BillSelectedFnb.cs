using System;
using System.Collections.Generic;

namespace FootNet.Models
{
    public partial class BillSelectedFnb
    {
        public string Billno { get; set; } = null!;
        public string FnbId { get; set; } = null!;
        public int Amount { get; set; }

        public virtual Bill BillnoNavigation { get; set; } = null!;
        public virtual Fnb Fnb { get; set; } = null!;
    }
}
