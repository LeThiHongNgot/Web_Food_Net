using Microsoft.AspNetCore.Mvc;
using FootNet.ViewModels;
namespace FootNet.Controllers
{
    public class UserController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
       

    }
}
