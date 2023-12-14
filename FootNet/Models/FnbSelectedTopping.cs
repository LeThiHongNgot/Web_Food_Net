using System;
using System.Collections.Generic;

namespace FootNet.Models
{
    public partial class FnbSelectedTopping
    {
        public string Toppingid { get; set; } = null!;
        public string FnbId { get; set; } = null!;
        public double PriceTp { get; set; }

        public virtual Fnb Fnb { get; set; } = null!;
        public virtual Topping Topping { get; set; } = null!;
    }
}
