using System;
using System.Web.Mvc;

namespace UAS.Core.Web.WebApp.Controllers
{
    using Facade;
    public class AccountController : Controller
    {
        private readonly Facade _facade;

        public AccountController()
        {
            _facade = new Facade();
        }

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Error()
        {
            return View();
        }

        public JsonResult Login(string username, string password)
        {
            try
            {
                _facade.CreateSession(username, password);
                return Json(new { success = true, url = Url.Action("Index", "Home"), message = string.Empty });
            }
            catch (Exception exception)
            {
                return Json(new { success = false, url = string.Empty, message = exception.Message });
            }
        }

        public ActionResult Logout()
        {
            try
            {
                _facade.CloseSession();
                return new RedirectToRouteResult(new System.Web.Routing.RouteValueDictionary(new { controller = "Account", action = "Index" }));
            }
            catch (Exception exception)
            {
                return new RedirectToRouteResult(new System.Web.Routing.RouteValueDictionary(new { controller = "Account", action = "Error" })); ;
            }
        }

    }
}
