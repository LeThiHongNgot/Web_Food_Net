using System;
using System.Collections.Generic;

namespace Admin_Baocao.Models
{
    public partial class Fnb
    {
        public Fnb()
        {
            BillSelectedFnbs = new HashSet<BillSelectedFnb>();
            Toppings = new HashSet<Topping>();
        }

        public string FnbId { get; set; } = null!;
        public string Categoryid { get; set; } = null!;
        public string? FnbName { get; set; }
        public int? Amountno { get; set; }
        public double? Price { get; set; }
        public string? Status { get; set; }
        public byte[]? Image { get; set; }

        public virtual Category Category { get; set; } = null!;
        public virtual ICollection<BillSelectedFnb> BillSelectedFnbs { get; set; }

        public virtual ICollection<Topping> Toppings { get; set; }
    }
}
