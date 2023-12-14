using FootNet.Models;

namespace FootNet.ViewModels
{
    public class UserFNb
    {
        public IEnumerable<Fnb> Products { get; set; }
        public IEnumerable<User> Users { get; set; }
    }
}
