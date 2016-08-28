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

            var currentAcademicPeriod = _facade.GetCurrentAcademicPeriod();
            var attendanceVsNonAttendanceStatistics = _facade.GetStatistictsAttendanceVsNonAttendance();
            var topExcuseClassifications = _facade.GetTopStatistictExcuseClassifications();
            var statisticsExcuseStatus = _facade.GetStatistictExcuseStatus();
            var topStatistictsMajorMonthsAttendanceAndNonAttendance =
                _facade.GetTopStatistictsMajorMonthsAttendanceAndNonAttendance();

            ViewBag.StatisticsAttendanceVsNonAttendance = attendanceVsNonAttendanceStatistics;
            ViewBag.CurrentAcademicPeriod = currentAcademicPeriod;
            ViewBag.TopExcuseClassifications = topExcuseClassifications;
            ViewBag.StatisticsExcuseStatus = statisticsExcuseStatus;
            ViewBag.TopStatistictsMajorMonthsAttendanceAndNonAttendance =
                topStatistictsMajorMonthsAttendanceAndNonAttendance;

            return View();
        }

        public ActionResult GraphStatistictsAttendanceVsNonAttendancePartial()
        {
            var currentAcademicPeriod = _facade.GetCurrentAcademicPeriod();
            var attendanceVsNonAttendanceStatistics = _facade.GetStatistictsAttendanceVsNonAttendance();
            ViewBag.StatisticsAttendanceVsNonAttendance = attendanceVsNonAttendanceStatistics;
            ViewBag.CurrentAcademicPeriod = currentAcademicPeriod;
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

        public ActionResult GraphStatistictsExcusesPartial()
        {
            var topExcuseClassifications = _facade.GetTopStatistictExcuseClassifications();
            var statisticsExcuseStatus = _facade.GetStatistictExcuseStatus();

            ViewBag.TopExcuseClassifications = topExcuseClassifications;
            ViewBag.StatisticsExcuseStatus = statisticsExcuseStatus;

            return PartialView();
        }

        public JsonResult GetStatistictsExcusesStatus()
        {
            var statistics = _facade.GetStatistictExcuseStatus();
            return Json(statistics);
        }

        private object GetExcusesSummary()
        {
            throw new NotImplementedException();
        }
        #endregion Methods
    }
}
