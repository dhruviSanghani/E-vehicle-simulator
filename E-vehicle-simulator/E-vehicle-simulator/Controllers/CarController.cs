using E_vehicle_simulator.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using MySqlConnector;

namespace E_vehicle_simulator.Controllers
{
    public class CarController : Controller
    {
        private MySqlConnection _mysql;
        private ConfigConnecion _con;
        public CarController(MySqlConnection mySql)
        {
            _mysql = mySql;
            _con = new ConfigConnecion(mySql);
        }
        // GET: CarController
        public ActionResult Index()
        {
            if (HttpContext.Session.GetString("Userdetails") != null)
            {
                string query = "SELECT c.*,eb.EVBrandName,ct.ChargingType FROM evcar c inner join evbrands eb on c.EvBrandID=eb.EVBrandID inner join chargingtype ct on c.ChargingTypeID=ct.ChargingTypeID;";

                IEnumerable<EvCarModel> cars = _con.Query<EvCarModel>(query);
                return View(cars);
            }
            else
            {
                return RedirectToAction("Login", "Account");
            }
        }

        // GET: CarController/Details/5
        public ActionResult Details(int id)
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

        // GET: CarController/Create
        public ActionResult Create()
        {
            if (HttpContext.Session.GetString("Userdetails") != null)
            {
                string brandquery = "SELECT * FROM evbrands;";
                ViewData["EVBrandId"] = new SelectList(_con.Query<EVBrandModel>(brandquery), "EVBrandID", "EVBrandName");
                string ctypequery = "SELECT * FROM chargingtype;";
                ViewData["CTypeId"] = new SelectList(_con.Query<ChargingTypeModel>(ctypequery), "ChargingTypeID", "ChargingType");
                return View();
            }
            else
            {
                return RedirectToAction("Login", "Account");
            }
        }

        // POST: CarController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(EvCarModel evCar)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    bool res = _con.ExecuteInsertQuery<EvCarModel>("evcar", evCar);

                    if (res)
                    {
                        return RedirectToAction(nameof(Index));
                    }
                    else
                    {
                        return View();
                    }
                }
                catch
                {
                    return View();
                }
            }
            return View();
        }

        // GET: CarController/Edit/5
        public ActionResult Edit(int id)
        {
            if (HttpContext.Session.GetString("Userdetails") != null)
            {
                string brandquery = "SELECT * FROM evbrands;";
                ViewData["EVBrandId"] = new SelectList(_con.Query<EVBrandModel>(brandquery), "EVBrandID", "EVBrandName");
                string ctypequery = "SELECT * FROM chargingtype;";
                ViewData["CTypeId"] = new SelectList(_con.Query<ChargingTypeModel>(ctypequery), "ChargingTypeID", "ChargingType");
                string sql = $"SELECT * FROM evcar where CarId={id};";
                EvCarModel ev = new EvCarModel();
                ev = _con.Query<EvCarModel>(sql).ToList().FirstOrDefault();
                return View(ev);
            }
            else
            {
                return RedirectToAction("Login", "Account");
            }
        }

        // POST: CarController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, EvCarModel evCar)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    bool res = _con.ExecuteUpdateQuery<EvCarModel>("evcar", evCar);

                    if (res)
                    {
                        return RedirectToAction(nameof(Index));
                    }
                    else
                    {
                        return View(evCar);
                    }
                }
                catch
                {
                    return View(evCar);
                }
            }
            return View(evCar);
        }

        //// GET: CarController/Delete/5
        //public ActionResult Delete(int id)
        //{
        //    return View();
        //}

        //// POST: CarController/Delete/5
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public ActionResult Delete(int id, IFormCollection collection)
        //{
        //    try
        //    {
        //        return RedirectToAction(nameof(Index));
        //    }
        //    catch
        //    {
        //        return View();
        //    }
        //}
    }
}
