using System.Web.Mvc;
using UAS.Core.Session;

namespace UAS.Core.Web.WebApp.Controllers
{
    public class FirewallController : Controller
    {
        private SessionManager _sessionManager;

        public FirewallController() {
            _sessionManager = new SessionManager();
        }

        protected override void OnAuthorization(AuthorizationContext filterContext)
        {
            base.OnAuthorization(filterContext);

            var session = _sessionManager.GetSession();

            if (session == null)
            {
                filterContext.Result = new RedirectToRouteResult(new System.Web.Routing.RouteValueDictionary(new { controller = "Account", action = "Index" }));
            }
            else {
                // Validate if the user has access to specific controller
            }
        }
    }
}