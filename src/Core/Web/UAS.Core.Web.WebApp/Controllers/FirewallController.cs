using System.Web.Mvc;
using System.Web.Routing;
using UAS.Core.Security;
using UAS.Core.Session;

namespace UAS.Core.Web.WebApp.Controllers
{
    public class FirewallController : Controller
    {
        private WebSecurity _webSecurity;
        protected SessionManager SessionManager;
        private const string DENIED_METHOD = "GET";

        /// <summary>
        /// Builder method
        /// </summary>
        public FirewallController() {
            _webSecurity = new WebSecurity();
            SessionManager = new SessionManager();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="filterContext"></param>
        protected override void OnAuthorization(AuthorizationContext filterContext)
        {
            base.OnAuthorization(filterContext);

            var session = SessionManager.GetSession();

            if (session == null)
            {
                filterContext.Result = new RedirectToRouteResult(
                    new RouteValueDictionary(new { controller = "Account", action = "Index" }));
            }
            else {
                // Validate if the user has access to specific controller
                var absolutePathUrlRequested = filterContext.HttpContext.Request.Url.AbsolutePath;
                var httpMethod = filterContext.HttpContext.Request.HttpMethod;
                var allowAccessToUrlRequested = _webSecurity.AllowAccessToPage(
                    absolutePathUrlRequested, session.SessionUser.Username, session.SessionUser.Password);

                if (!allowAccessToUrlRequested && httpMethod.Equals(DENIED_METHOD)) {
                    filterContext.Result = new RedirectToRouteResult(
                        new RouteValueDictionary(new { controller = "Account", action = "Error" }));
                }
            }
        }
    }
}