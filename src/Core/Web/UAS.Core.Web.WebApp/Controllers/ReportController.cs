using System.Web.Mvc;

namespace UAS.Core.Web.WebApp.Controllers
{
    public class ReportController : SessionController
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}