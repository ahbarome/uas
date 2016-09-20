using log4net;
using System;
using System.Web.Mvc;
using System.Web.Routing;

namespace UAS.Core.Web.WebApp.Controllers
{
    using Facade;

    public class AccountController : Controller
    {
        /// <summary>
        /// Logger for the controller
        /// </summary>
        private static readonly ILog _logger =
            LogManager.GetLogger(
                System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// 
        /// </summary>
        private readonly Facade _facade;

        public AccountController()
        {
            _facade = new Facade();
        }

        public ActionResult Index()
        {
            var session = _facade.GetSession();
            if (session != null)
            {
                return new RedirectToRouteResult(
                        new RouteValueDictionary(new { controller = "Home", action = "Index" }));
            }
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
                _logger.Error(exception.Message, exception);
                return Json(new { success = false, url = string.Empty, message = exception.Message });
            }
        }

        public ActionResult Logout()
        {
            try
            {
                _facade.CloseSession();
                return new RedirectToRouteResult(new RouteValueDictionary(new { controller = "Account", action = "Index" }));
            }
            catch (Exception exception)
            {
                _logger.Error(exception.Message, exception);
                return new RedirectToRouteResult(new RouteValueDictionary(new { controller = "Account", action = "Error" })); ;
            }
        }

    }
}
