using System.Web.Mvc;

namespace UAS.Core.Web.WebApp.Controllers
{
    public class HomeController : SessionController
    {
        public ActionResult Index()
        {
            var session = base.CurrentSession;
            ViewBag.Title = "Home Page";
            ViewData.Add("SESSION", session);
            ViewData.Add("USERNAME", session.SessionUser.Username);
            return View();
        }
    }
}
