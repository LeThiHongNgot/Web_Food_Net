using System;
using System.Collections.Generic;

namespace FootNet.Models
{
    public partial class Topping
    {
        public Topping()
        {
            Fnbs = new HashSet<Fnb>();
        }

        public string Toppingid { get; set; } = null!;
        public string? Toppingname { get; set; }
        public int? Amount { get; set; }
        public double? Price { get; set; }

        public virtual ICollection<Fnb> Fnbs { get; set; }
    }
}
