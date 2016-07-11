using System.Web.Mvc;
using UAS.Core.Configuration;

namespace UAS.Core.Web.WebApp.Controllers
{
    using Session.Entities;

    public class HomeController : FirewallController
    {
        public ActionResult Index()
        {
            var session = System.Web.HttpContext.Current.Session[ConfigurationManager.SESSION_KEY] as Session;
            ViewBag.Title = "Home Page";
            ViewData.Add("SESSION", session);
            ViewData.Add("USERNAME", session.SessionUser.Username);
            return View();
        }
    }
}
