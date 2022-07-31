using Microsoft.AspNetCore.Mvc;
using E_vehicle_simulator.Models;
using MySqlConnector;

namespace E_vehicle_simulator.Controllers
{
    public class AccountController : Controller
    {
        private MySqlConnection _mysql;
        private ConfigConnecion _con;
        public AccountController(MySqlConnection mySql)
        {
            _mysql = mySql;
            _con = new ConfigConnecion(mySql);
        }
        public IActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public IActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public IActionResult Login(LoginModel login)
        {
            if(string.IsNullOrEmpty(login.UserName) && string.IsNullOrEmpty(login.Password))
            {
                ViewBag.Errormsg = "User name or password is missing";
                return View();
            }
            else
            {                
                string query = "Select * from users where username='" + login.UserName + "' and password='" + login.Password + "';";
                
                UsersModel users = _con.Query<UsersModel>(query).ToList().FirstOrDefault();
               
                if (users!=null)
                {
                    HttpContext.Session.SetString("Userdetails", users.FullName);
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    ViewData["message"] = "Login Failed. Please check your username and password";
                }
            }
            return View();
        }

        [HttpGet]
        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Login", "Account");
        }
    }
}
