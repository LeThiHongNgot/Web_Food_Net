using System;
using System.Collections.Generic;

namespace Admin_Baocao.Models
{
    public partial class Category
    {
        public Category()
        {
            Fnbs = new HashSet<Fnb>();
        }

        public string Categoryid { get; set; } = null!;
        public string? Categoryname { get; set; }
        public string? Type { get; set; }

        public virtual ICollection<Fnb> Fnbs { get; set; }
    }
}
