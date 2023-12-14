using FootNet.Models;
using FootNet.ViewModels;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Data.SqlClient.Server;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;

namespace FootNet.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly QLNetContext _context;
        public HomeController(ILogger<HomeController> logger, QLNetContext context)
        {
            _logger = logger;
            _context = context;
        }

        public IActionResult Index()
        {
            var products = _context.Fnbs.ToList();
           var users = _context.Users.ToList();

            var viewModel = new UserFNb
            {
                Products = products,
                Users = users,
            };

            return View(viewModel);
           
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

        public IActionResult GetToppings(string fnbId)
        {
            var toppingIds = _context.FnbSelectedToppings
                .Where(ft => ft.FnbId == fnbId)
                .Select(ft => ft.Toppingid)
                .ToList();

            var toppings = _context.Toppings
            .Where(t => toppingIds.Contains(t.Toppingid))
            .Select(t => new
            {
                ToppingId = t.Toppingid,
                ToppingName = t.Toppingname,
                Price = t.Price
            })
            .ToList();
            return Json(toppings);
        }
        public IActionResult GetProductImage(string fnbId)
        {
            var product = _context.Fnbs.FirstOrDefault(f => f.FnbId == fnbId);
            return Json(product?.Image);
        }
        [HttpPost("/Create")]
        public async Task<IActionResult> Create([FromForm] User user)
        {
            try
            {
                // Check if the email is already registered
                var existingUser = await _context.Users.FirstOrDefaultAsync(u => u.Email == user.Email);
                if (existingUser != null)
                {
                    return BadRequest(new { Errors = new[] { "Tài khoản đã được đăng ký" } });
                }

                if (ModelState.IsValid)
                {
                    _context.Add(user);
                    await _context.SaveChangesAsync();
                    // Return 200 status code for success
                    return StatusCode(200);
                }

                // If there are validation errors, return details in the response
                var errors = ModelState.Values.SelectMany(v => v.Errors.Select(e => e.ErrorMessage));
                return BadRequest(new { Errors = errors });
            }
            catch (Exception ex)
            {
                return BadRequest(new { Errors = new[] { ex.Message } });
            }
        }
        /*[HttpPost("/Login")]
        public async Task<IActionResult> Login([FromForm] User model)
        {
            try
            {
                // Find the user based on the provided email
                var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == model.Email);

                // Check if the user exists and if the provided password matches
                if (user != null && user.Password == model.Password)
                {
                    // Successful login, return the user's name
                    return Ok(new { UserName = user.Username });
                }

                // Login failed, return a failure status
                return BadRequest(new { Errors = new[] { "Invalid email or password" } });
            }
            catch (Exception ex)
            {
                return BadRequest(new { Errors = new[] { ex.Message } });
            }
        }*/

    }
}