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
            var topStatistictAttendanceAndNonAttendanceTeacherCourse =
                _facade.GetTopStatistictAttendanceAndNonAttendanceTeacherCourse();
            var topStatistictAttendanceAndNonAttendanceStudentCourse =
                _facade.GetTopStatistictAttendanceAndNonAttendanceStudentCourse();
            var topStatistictsMajorCourseAttendanceAndNonAttendance = 
                _facade.GetTopStatistictsMajorCourseAttendanceAndNonAttendance();

            ViewBag.StatisticsAttendanceVsNonAttendance = attendanceVsNonAttendanceStatistics;
            ViewBag.CurrentAcademicPeriod = currentAcademicPeriod;
            ViewBag.TopExcuseClassifications = topExcuseClassifications;
            ViewBag.StatisticsExcuseStatus = statisticsExcuseStatus;
            ViewBag.TopStatistictsMajorMonthsAttendanceAndNonAttendance =
                topStatistictsMajorMonthsAttendanceAndNonAttendance;
            ViewBag.TopStatistictAttendanceAndNonAttendanceTeacherCourse =
                topStatistictAttendanceAndNonAttendanceTeacherCourse;
            ViewBag.TopStatistictAttendanceAndNonAttendanceStudentCourse =
                topStatistictAttendanceAndNonAttendanceStudentCourse;
            ViewBag.TopStatistictsMajorCourseAttendanceAndNonAttendance =
                topStatistictsMajorCourseAttendanceAndNonAttendance;

            return View();
        }

        public ActionResult StatisticsAttendanceVsNonAttendancePartial()
        {
            var currentAcademicPeriod = _facade.GetCurrentAcademicPeriod();
            var attendanceVsNonAttendanceStatistics = _facade.GetStatistictsAttendanceVsNonAttendance();

            ViewBag.StatisticsAttendanceVsNonAttendance = attendanceVsNonAttendanceStatistics;
            ViewBag.CurrentAcademicPeriod = currentAcademicPeriod;

            return PartialView();
        }

        public JsonResult GetStatisticsAttendanceVsNonAttendance()
        {
            var statistics = _facade.GetStatistictsAttendanceVsNonAttendance();
            return Json(statistics);
        }

        public ActionResult StatisticsNonAttendancePartial()
        {
            var currentAcademicPeriod = _facade.GetCurrentAcademicPeriod();
            var topStatistictAttendanceAndNonAttendanceTeacherCourse =
               _facade.GetTopStatistictAttendanceAndNonAttendanceTeacherCourse();
            var topStatistictAttendanceAndNonAttendanceStudentCourse =
                _facade.GetTopStatistictAttendanceAndNonAttendanceStudentCourse();
            var topStatistictsMajorCourseAttendanceAndNonAttendance =
                _facade.GetTopStatistictsMajorCourseAttendanceAndNonAttendance();

            ViewBag.CurrentAcademicPeriod = currentAcademicPeriod;
            ViewBag.TopStatistictAttendanceAndNonAttendanceTeacherCourse =
                topStatistictAttendanceAndNonAttendanceTeacherCourse;
            ViewBag.TopStatistictAttendanceAndNonAttendanceStudentCourse =
                topStatistictAttendanceAndNonAttendanceStudentCourse;
            ViewBag.TopStatistictsMajorCourseAttendanceAndNonAttendance =
                topStatistictsMajorCourseAttendanceAndNonAttendance;

            return PartialView();
        }


        public ActionResult StatisticsExcusesPartial()
        {
            var topExcuseClassifications = _facade.GetTopStatistictExcuseClassifications();
            var statisticsExcuseStatus = _facade.GetStatistictExcuseStatus();

            ViewBag.TopExcuseClassifications = topExcuseClassifications;
            ViewBag.StatisticsExcuseStatus = statisticsExcuseStatus;

            return PartialView();
        }

        public JsonResult GetStatisticsExcusesStatus()
        {
            var statistics = _facade.GetStatistictExcuseStatus();
            return Json(statistics);
        }
        #endregion Methods
    }
}
