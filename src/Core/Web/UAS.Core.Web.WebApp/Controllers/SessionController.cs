using System.Web.Mvc.Filters;

namespace UAS.Core.Web.WebApp.Controllers
{
    using Session.Entities;

    public class SessionController : FirewallController
    {
        private Session _currentSession;

        public Session CurrentSession
        {
            get { return _currentSession; }
            set { _currentSession = value; }
        }

        protected override void OnAuthentication(AuthenticationContext filterContext)
        {
            base.OnAuthentication(filterContext);

            _currentSession = SessionManager.GetSession();
        }
    }
}