using System;
using System.Collections.Generic;

namespace FootNet.Models
{
    public partial class Service
    {
        public Service()
        {
            UserSelectedServices = new HashSet<UserSelectedService>();
        }

        public string Servicesid { get; set; } = null!;
        public string? Servicesname { get; set; }
        public byte[]? Image { get; set; }
        public string? Description { get; set; }

        public virtual ICollection<UserSelectedService> UserSelectedServices { get; set; }
    }
}
