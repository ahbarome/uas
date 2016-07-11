using System.Web.Mvc;

namespace UAS.Core.Web.WebApp.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            var session = System.Web.HttpContext.Current.Session["SESSION"];
            ViewBag.Title = "Home Page";

            return View();
        }
    }
}
