using E_vehicle_simulator.Models;
using Microsoft.AspNetCore.Mvc;
using MySqlConnector;
using System.Diagnostics;

namespace E_vehicle_simulator.Controllers
{
    [ResponseCache(Location = ResponseCacheLocation.None, NoStore = true)]
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private MySqlConnection _mysql;
        private ConfigConnecion _con;

        public HomeController(ILogger<HomeController> logger, MySqlConnection mySql)
        {
            _logger = logger;
            _mysql = mySql;
            _con = new ConfigConnecion(mySql);
        }

        public IActionResult Index()
        {
            if (HttpContext.Session.GetString("Userdetails") != null)
            {
                return View();
            }
            else
            {
                return RedirectToAction("Login", "Account");
            }
        }

        public IActionResult Direction(int id)
        {
            if (HttpContext.Session.GetString("Userdetails") != null)
            {
                string sql = $"SELECT c.*,eb.EVBrandName,ct.ChargingType FROM evcar c inner join evbrands eb on c.EvBrandID=eb.EVBrandID inner join chargingtype ct on c.ChargingTypeID=ct.ChargingTypeID where c.CarId={id};";
                EvCarModel ev = new EvCarModel();
                ev = _con.Query<EvCarModel>(sql).ToList().FirstOrDefault();
                return View(ev);
            }
            else
            {
                return RedirectToAction("Login", "Account");
            }
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}