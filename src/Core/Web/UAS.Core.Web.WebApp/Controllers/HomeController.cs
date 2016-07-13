using System.Web.Mvc;
using UAS.Core.Configuration;

namespace UAS.Core.Web.WebApp.Controllers
{
    public class HomeController : SessionController
    {
        public ActionResult Index()
        {
            var session = base.CurrentSession;
            ViewBag.Title = "Home Page";
            ViewData.Add(ConfigurationManager.SESSION_KEY, session);
            ViewData.Add("USERNAME", session.SessionUser.Username);
            return View();
        }
    }
}
