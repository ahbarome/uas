using System.Web.Mvc;

namespace UAS.Core.Web.WebApp.Controllers
{
    public class LayoutController : SessionController
    {
        // GET: Layout
        public ActionResult Navigation()
        {
            var session = base.CurrentSession;
            ViewData.Add("SESSION", session);
            return PartialView("_Navigation");
        }

        // GET: Layout
        public ActionResult TopNavbar()
        {
            var session = base.CurrentSession;
            ViewData.Add("SESSION", session);
            return PartialView("_TopNavbar");
        }
    }
}