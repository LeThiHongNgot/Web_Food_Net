using Microsoft.AspNetCore.Mvc;
using FootNet.ViewModels;
namespace FootNet.Controllers
{
    public class User : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
       
    }
}
