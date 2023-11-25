using System;
using System.Collections.Generic;

namespace FootNet.Models
{
    public partial class Service
    {
        public Service()
        {
            Users = new HashSet<User>();
        }

        public string Servicesid { get; set; } = null!;
        public string? Servicesname { get; set; }
        public string? Description { get; set; }

        public virtual ICollection<User> Users { get; set; }
    }
}
