using FootNet.Models;
using FootNet.ViewModels;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace FootNet.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;

        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
        public IActionResult Add()
        {
            return View();
        }


        [HttpPost]
        public IActionResult Add(AddUserViewModels addUserViewModel)
        {
            if (ModelState.IsValid)
            {
                return View("Index");
            }
/*gh*/
            return View(addUserViewModel);
        }
    }
}