using System;
using System.Collections.Generic;

namespace FootNet.Models
{
    public partial class Topping
    {
        public Topping()
        {
            FnbSelectedToppings = new HashSet<FnbSelectedTopping>();
        }

        public string Toppingid { get; set; } = null!;
        public string? Toppingname { get; set; }
        public int? Amount { get; set; }
        public double? Price { get; set; }

        public virtual ICollection<FnbSelectedTopping> FnbSelectedToppings { get; set; }
    }
}
