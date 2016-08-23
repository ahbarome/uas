using System;
using System.Web.Mvc;
using UAS.Core.Configuration;

namespace UAS.Core.Web.WebApp.Controllers
{
    public class HomeController : SessionController
    {
        #region Attributes
        /// <summary>
        /// 
        /// </summary>
        private Facade.Facade _facade;
        #endregion Attributes

        #region Methods

        /// <summary>
        /// Builder method
        /// </summary>
        public HomeController()
        {
            _facade = new Facade.Facade();
        }

        public ActionResult Index()
        {
            var session = base.CurrentSession;
            ViewData.Add(ConfigurationManager.SESSION_KEY, session);
            ViewData.Add("USERNAME", session.SessionUser.Username);
            return View();
        }

        public ActionResult GraphStatistictsAttendanceVsNonAttendance() {
            return PartialView();
        }

        public JsonResult GetStatistictsAttendanceVsNonAttendance()
        {
            var statistics = _facade.GetStatistictsAttendanceVsNonAttendance();
            return Json(statistics);
        }

        public ActionResult DashboardNonAttendance()
        {
            var summary = GetNonAttendanceSummary();
            return View();
        }

        private object GetNonAttendanceSummary()
        {
            throw new NotImplementedException();
        }

        public ActionResult DashboardExcuses()
        {
            var summary = GetExcusesSummary();
            return View();
        }

        private object GetExcusesSummary()
        {
            throw new NotImplementedException();
        }
        #endregion Methods
    }
}
