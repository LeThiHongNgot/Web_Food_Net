using Admin_Baocao.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Diagnostics;
using System.Net;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

namespace Admin_Baocao.Controllers
{
    public class AdminController : Controller
    {
        private readonly QLNetContext _context;
        public AdminController(QLNetContext context)
        {
            _context = context;
        }
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult BaoCao()
        {
            return View();
        }

		public IActionResult DanhMuc()
		{
			return View();
		}

		public IActionResult MatHang()
		{
			return View();
		}

		[HttpPost]
		public IActionResult CreateCategory([FromBody]Category category)
		{
			_context.Categories.Add(category);
			_context.SaveChanges();
			return Ok();
		}

		[HttpPost]
		public IActionResult UpdateCategory([FromQuery]string targetCatId, [FromBody]Category category)
		{
			if (category.Categoryname != null)
			{
				var newCategory = _context.Categories.Find(targetCatId);
				if (newCategory != null)
				{
					newCategory.Categoryname = category.Categoryname;
				}
				_context.SaveChanges();
				return Ok();
			}
			return NotFound("Không tìm thấy danh mục cần sửa !");
		}


		[HttpDelete]
		public IActionResult DeleteCategory([FromQuery]string targetCatId)
		{
			var category = _context.Categories.Find(targetCatId);
			if(category != null)
			{
				var fnbs = _context.Fnbs.Where(fnb => fnb.Categoryid == targetCatId);
				if (fnbs.Count() > 0)
				{
					return BadRequest("Không thể xóa danh mục vì đang có mặt hàng thuộc danh mục này !");
				}
				else
				{
					_context.Categories.Remove(category);
					_context.SaveChanges();
					return Ok();
				}
			}
			return NotFound("Không tìm thấy danh mục !");
		}


		[HttpPost]
		public IActionResult CreateFnb([FromBody]Fnb fnb)
		{
			if (fnb != null)
			{
				var sameFnbsCount = _context.Fnbs.Count(aFnb => aFnb.FnbId == fnb.FnbId);
				if (sameFnbsCount > 0)
				{
					return BadRequest("Mã mặt hàng đã tồn tại trong hệ thống !");
				}
				else
				{
					_context.Fnbs.Add(fnb);
					_context.SaveChanges();
					return Ok();
				}
			}
			return BadRequest("Không tìm thấy thông tin mặt hàng cần thêm !");
		}

		[HttpPost]
		public IActionResult UpdateFnb([FromQuery]string targetFnbId, [FromBody]Fnb fnb)
		{
			var targetFnb = _context.Fnbs.Where(fnb => fnb.FnbId == targetFnbId).Include(fnb => fnb.Toppings).FirstOrDefault();
			if (targetFnb != null)
			{
				var fnbExistInBillCount = _context.BillSelectedFnbs.Count(bill => bill.FnbId == targetFnbId);
				var fnbExistInToppingCount = targetFnb.Toppings.Count;
				if (fnb.FnbName != null)
				{
					if(fnbExistInBillCount > 0 || fnbExistInToppingCount > 0)
					{
						return BadRequest("Không được sửa tên mặt hàng đang được lưu trong hóa đơn khách hàng hoặc hóa đơn topping !");
					}
					else
					{
						targetFnb.FnbName = fnb.FnbName;	
					}
				}

				if(fnb.Price != null)
				{
					if(fnbExistInBillCount > 0 || fnbExistInToppingCount > 0)
					{
						return BadRequest("Không được sửa giá của mặt hàng đang được lưu trong hóa đơn khách hàng hoặc hóa đơn topping !");
					}
					else
					{
						targetFnb.Price = fnb.Price;
					}
				}

				if(fnb.Image != null)
				{
					targetFnb.Image = fnb.Image;
				}

				if(fnb.Categoryid != null)
				{
					var catExist = _context.Categories.Count(cat=>cat.Categoryid == fnb.Categoryid);
                    if (catExist == 0)
                    {
						return BadRequest("Không tìm thấy danh mục trong hệ thống !");
                    }
					else
					{
						targetFnb.Categoryid = fnb.Categoryid;
					}
				}
				_context.SaveChanges();
				return Ok();
			}
			return BadRequest("Không tìm thấy mặt hàng cần sửa !");
		}

		[HttpDelete]
		public IActionResult DeleteFnb([FromQuery]string targetFnbId)
		{
			var fnb = _context.Fnbs.Where(fnb=>fnb.FnbId == targetFnbId).Include(fnb=>fnb.Toppings).FirstOrDefault();
			if(fnb != null)
			{
				var fnbExistInBillCount = _context.BillSelectedFnbs.Count(bill=>bill.FnbId == targetFnbId);
				var fnbExistInToppingCount = fnb.Toppings.Count;
				if(fnbExistInBillCount > 0 || fnbExistInToppingCount > 0)
				{
					return BadRequest("Không thể xóa mặt hàng đang được lưu trong hóa đơn khách hàng hoặc hóa đơn topping !");
				}
				else
				{
					_context.Fnbs.Remove(fnb);
					_context.SaveChanges();
					return Ok();
				}
			}
			return NotFound("Không tìm thấy mặt hàng !");
		}

		[HttpGet]
		[Route("/Admin/CheckCategoryExists/{categoryId}")]
		public async Task<IActionResult> CheckCatExist(string categoryId)
		{
			var result = await _context.Categories.CountAsync(category => category.Categoryid == categoryId);
			return Ok(result);
		}

        [HttpGet]
        public async Task<ActionResult<List<Category>>> GetCategories()
        {
            return Ok(await _context.Categories.ToListAsync());
        }

		[HttpGet]
		[Route("/Admin/GetReportCat")]
		public async Task<ActionResult> GetReportCat()
		{
			var result = await _context.Categories
				.Include(category => category.Fnbs)
				.GroupBy(report => new { report.Categoryid, report.Categoryname })
				.Select(report => new
				{
					categoryId = report.Key.Categoryid,
					categoryName = report.Key.Categoryname,
					totalAmount = report.Select(r=>r.Fnbs.Count)
				})
				.ToListAsync();
			return Ok(result);
		}

		[HttpGet]
		[Route("/Admin/GetReportFnb")]
		public async Task<ActionResult> GetReportFnb()
		{
			var result = await _context.Fnbs
			   .Include(fnb => fnb.Category)
			   .Select(report => new
			   {
				   categoryName = report.Category.Categoryname,
				   fnbId = report.FnbId,
				   fnbName = report.FnbName,
				   fnbImage = report.Image,
				   Price = report.Price,
			   })
			   .ToListAsync();
			return Ok(result);
		}

		[HttpGet]
		[Route("/Admin/GetReportCat/ById/{categoryId}")]
		public async Task<ActionResult> GetReportCatById(string categoryId)
		{
			var result = await _context.Categories
				.Include(category => category.Fnbs)
				.GroupBy(report => new { report.Categoryid, report.Categoryname })
				.Select(report => new
				{
					categoryId = report.Key.Categoryid,
					categoryName = report.Key.Categoryname,
					totalAmount = report.Select(r => r.Fnbs.Count)
				})
				.Where(category=>category.categoryId==categoryId)
				.ToListAsync();
			return Ok(result);
		}

        [HttpGet]
        public async Task<ActionResult<List<Fnb>>> GetProducts()
        {
            return Ok(await _context.Fnbs.ToListAsync());
        }

        [HttpGet]
		[Route("/Admin/GetProducts/ById/{categoryId}")]
        public async Task<ActionResult<List<Fnb>>> GetProductsById(string categoryId)
        {
            var result = await _context.Fnbs.Where(fnb=>fnb.Categoryid==categoryId).ToListAsync();
            return Ok(result);
        }

        [HttpGet]
        [Route("/Admin/GetReportProducts/ById/{categoryId}")]
        public async Task<ActionResult> GetFnbByCatId(string categoryId)
        {
			var result = await _context.BillSelectedFnbs
			   .Include(billfnb => billfnb.Fnb)
			   .ThenInclude(fnb => fnb.Category)
			   .Where(fnb => fnb.Fnb.Categoryid == categoryId)
			   .GroupBy(report => new { report.FnbId, report.Fnb.Categoryid, report.Fnb.FnbName, report.Fnb.Category.Categoryname, report.Fnb.Price })
			   .Select(report => new
			   {
				   FNBId = report.Key.FnbId,
				   CategoryId = report.Key.Categoryid,
				   FNBName = report.Key.FnbName,
				   CategoryName = report.Key.Categoryname,
				   TotalAmount = report.Sum(r => r.Amount),
				   Price = report.Key.Price
			   })
			   .ToListAsync();
			return Ok(result);
		}

		[HttpGet]
		[Route("/Admin/GetReportProducts/ById/ByDate/{categoryId}&{fromDate}&{toDate}")]
		public async Task<ActionResult> GetFnbByCatId(string categoryId, DateTime fromDate, DateTime toDate)
		{
			var result = await _context.BillSelectedFnbs
			   .Include(billfnb => billfnb.Fnb)
			   .ThenInclude(fnb => fnb.Category)
			   .Include(billfnb => billfnb.BillnoNavigation)
				.Where(report => report.Fnb.Categoryid == categoryId && report.BillnoNavigation.Daytime.Value.Date >= fromDate && report.BillnoNavigation.Daytime.Value.Date <= toDate.Date)
			   .GroupBy(report => new { report.FnbId, report.Fnb.Categoryid, report.Fnb.FnbName, report.Fnb.Category.Categoryname, report.Fnb.Price})
			   .Select(report => new
			   {
				   FNBId = report.Key.FnbId,
				   CategoryId = report.Key.Categoryid,
				   FNBName = report.Key.FnbName,
				   CategoryName = report.Key.Categoryname,
				   TotalAmount = report.Sum(r => r.Amount),
				   Price = report.Key.Price,
				   BillDaytime = report.Max(r => r.BillnoNavigation.Daytime)
			   })
			   .ToListAsync();
			return Ok(result);
		}

		[HttpGet]
		[Route("/Admin/GetReportFnb/ByCatId/{categoryId}")]
		public async Task<ActionResult> GetReportFnbByCatId(string categoryId)
		{
			var result = await _context.Fnbs
			   .Include(fnb => fnb.Category)
			   .Where(fnb => fnb.Categoryid == categoryId)
			   .Select(report => new
			   {
				   categoryName = report.Category.Categoryname,
				   fnbId = report.FnbId,
				   fnbName = report.FnbName,
				   fnbImage = report.Image,
				   Price = report.Price,
			   })
			   .ToListAsync();
			return Ok(result);
		}

		[HttpGet]
		[Route("/Admin/GetFnb/ById/{fnbId}")]
		public async Task<ActionResult> GetFnbById(string fnbId)
		{
			var result = await _context.BillSelectedFnbs
			   .Include(billfnb => billfnb.Fnb)
			   .ThenInclude(fnb => fnb.Category)
			   .Where(fnb => fnb.FnbId == fnbId)
			   .GroupBy(report => new { report.FnbId, report.Fnb.Categoryid, report.Fnb.FnbName, report.Fnb.Category.Categoryname, report.Fnb.Price })
			   .Select(report => new
			   {
				   FNBId = report.Key.FnbId,
				   CategoryId = report.Key.Categoryid,
				   FNBName = report.Key.FnbName,
				   CategoryName = report.Key.Categoryname,
				   TotalAmount = report.Sum(r => r.Amount),
				   Price = report.Key.Price
			   })
			   .ToListAsync();
			return Ok(result);
		}

        [HttpGet]
        [Route("/Admin/GetFnb/ById/ByDate/{fnbId}&{fromDate}&{toDate}")]
        public async Task<ActionResult> GetFnbById(string fnbId, DateTime fromDate, DateTime toDate)
        {
			var result = await _context.BillSelectedFnbs
			   .Include(billfnb => billfnb.Fnb)
			   .ThenInclude(fnb => fnb.Category)
			   .Include(billfnb => billfnb.BillnoNavigation)
			   .Where(report => report.Fnb.FnbId == fnbId && report.BillnoNavigation.Daytime.Value.Date >= fromDate.Date && report.BillnoNavigation.Daytime.Value.Date <= toDate.Date)
			   .GroupBy(report => new { report.FnbId, report.Fnb.Categoryid, report.Fnb.FnbName, report.Fnb.Category.Categoryname, report.Fnb.Price})
			   .Select(report => new
			   {
				   FNBId = report.Key.FnbId,
				   CategoryId = report.Key.Categoryid,
				   FNBName = report.Key.FnbName,
				   CategoryName = report.Key.Categoryname,
				   TotalAmount = report.Sum(r => r.Amount),
				   Price = report.Key.Price,
				   BillDaytime = report.Max(r => r.BillnoNavigation.Daytime)
			   })
			   .ToListAsync();
			return Ok(result);
		}

		[HttpGet]
		[Route("/Admin/GetReportFnb/ById/{fnbId}")]
		public async Task<ActionResult> GetReportFnbById(string fnbId)
		{
			var result = await _context.Fnbs
			   .Include(fnb => fnb.Category)
			   .Where(fnb => fnb.FnbId == fnbId)
			   .Select(report => new
			   {
				   categoryName = report.Category.Categoryname,
				   fnbId = report.FnbId,
				   fnbName = report.FnbName,
				   fnbImage = report.Image,
				   Price = report.Price,
			   })
			   .ToListAsync();
			return Ok(result);
		}


		[HttpGet]
        public async Task<ActionResult> GetSaleReport()
        {
            var result = await _context.BillSelectedFnbs
                .Include(billfnb => billfnb.Fnb)
                .ThenInclude(fnb => fnb.Category)
                .GroupBy(report => new { report.FnbId, report.Fnb.Categoryid, report.Fnb.FnbName, report.Fnb.Category.Categoryname, report.Fnb.Price })
                .Select(report => new
                {
                    FNBId = report.Key.FnbId,
                    CategoryId = report.Key.Categoryid,
                    FNBName = report.Key.FnbName,
                    CategoryName = report.Key.Categoryname,
                    TotalAmount = report.Sum(r => r.Amount),
                    Price = report.Key.Price
                })
                .ToListAsync();
            return Ok(result);
        }


        [HttpGet]
        [Route("/Admin/GetSaleReport/ByDate/{fromDate}&{toDate}")]
        public async Task<ActionResult> GetSaleReportByDate(DateTime fromDate, DateTime toDate)
        {
			var result = await _context.BillSelectedFnbs
			   .Include(billfnb => billfnb.Fnb)
			   .ThenInclude(fnb => fnb.Category)
			   .Include(billfnb=>billfnb.BillnoNavigation)
			   .Where(report => report.BillnoNavigation.Daytime.Value.Date >= fromDate.Date && report.BillnoNavigation.Daytime.Value.Date <= toDate.Date)
			   .GroupBy(report => new { report.FnbId, report.Fnb.Categoryid, report.Fnb.FnbName, report.Fnb.Category.Categoryname, report.Fnb.Price})
			   .Select(report => new
			   {
				   FNBId = report.Key.FnbId,
				   CategoryId = report.Key.Categoryid,
				   FNBName = report.Key.FnbName,
				   CategoryName = report.Key.Categoryname,
				   TotalAmount = report.Sum(r => r.Amount),
				   Price = report.Key.Price,
				   BillDaytime = report.Max(r => r.BillnoNavigation.Daytime)
			   })
			   .ToListAsync();
			return Ok(result);
		}


        public IActionResult Privacy()
        {
            return View();
        }
    }
}