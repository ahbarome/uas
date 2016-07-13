using System.Web.Mvc;
using UAS.Core.Configuration;

namespace UAS.Core.Web.WebApp.Controllers
{
    public class LayoutController : SessionController
    {
        // GET: Layout
        public ActionResult Navigation()
        {
            var session = base.CurrentSession;
            ViewData.Add(ConfigurationManager.SESSION_KEY, session);
            return PartialView("_Navigation");
        }

        // GET: Layout
        public ActionResult TopNavbar()
        {
            var session = base.CurrentSession;
            ViewData.Add(ConfigurationManager.SESSION_KEY, session);
            return PartialView("_TopNavbar");
        }
    }
}