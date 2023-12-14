using System;
using System.Collections.Generic;

namespace FootNet.Models
{
    public partial class UserSelectedService
    {
        public string Userid { get; set; } = null!;
        public string Servicesid { get; set; } = null!;
        public string? Description { get; set; }

        public virtual Service Services { get; set; } = null!;
        public virtual User User { get; set; } = null!;
    }
}
