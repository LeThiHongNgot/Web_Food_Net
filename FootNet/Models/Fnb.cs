using System;
using System.Collections.Generic;

namespace FootNet.Models
{
    public partial class Fnb
    {
        public Fnb()
        {
            BillSelectedFnbs = new HashSet<BillSelectedFnb>();
            FnbSelectedToppings = new HashSet<FnbSelectedTopping>();
        }

        public string FnbId { get; set; } = null!;
        public string Categoryid { get; set; } = null!;
        public string? FnbName { get; set; }
        public int? Amountno { get; set; }
        public double? Price { get; set; }
        public string? Status { get; set; }
        public string? Image { get; set; }

        public virtual Category Category { get; set; } = null!;
        public virtual ICollection<BillSelectedFnb> BillSelectedFnbs { get; set; }
        public virtual ICollection<FnbSelectedTopping> FnbSelectedToppings { get; set; }
    }
}
