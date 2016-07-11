using System;
using System.Web.Mvc;

namespace UAS.Core.Web.WebApp.Controllers
{
    using Facade;
    public class AccountController : Controller
    {
        private readonly Facade _facade = new Facade();

        public AccountController()
        {
        }

        public ActionResult Index()
        {
            return View();
        }

        public JsonResult Login(string username, string password)
        {
            
            try {
                _facade.CreateSession(username, password);
                return Json(new { success = true,  url = Url.Action("Index", "Home"), message = string.Empty });
            }
            catch(Exception exception) {
                return Json(new { success = false, url = string.Empty, message = exception.Message });
            }
        }

    }
}
