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
            var roleId = session.SessionUser.IdRole;
            var documentNumber = session.SessionUser.DocumentNumber;

            ViewData.Add(ConfigurationManager.SESSION_KEY, session);
            ViewData.Add("USERNAME", session.SessionUser.Username);

            var currentAcademicPeriod = _facade.GetCurrentAcademicPeriod();
            var attendanceVsNonAttendanceStatistics = 
                _facade.GetStatistictsAttendanceVsNonAttendance(documentNumber, roleId);
            var topExcuseClassifications = 
                _facade.GetTopStatistictExcuseClassifications(documentNumber , roleId);
            var statisticsExcuseStatus = _facade.GetStatistictExcuseStatus(documentNumber, roleId);
            var topStatistictsMajorMonthsAttendanceAndNonAttendance =
                _facade.GetTopStatistictsMajorMonthsAttendanceAndNonAttendance(documentNumber, roleId);
            var topStatistictAttendanceAndNonAttendanceTeacherCourse =
                _facade.GetTopStatistictAttendanceAndNonAttendanceTeacherCourse(documentNumber, roleId);
            var topStatistictAttendanceAndNonAttendanceStudentCourse =
                _facade.GetTopStatistictAttendanceAndNonAttendanceStudentCourse(
                    documentNumber , roleId);
            var topStatistictsMajorCourseAttendanceAndNonAttendance = 
                _facade.GetTopStatistictsMajorCourseAttendanceAndNonAttendance(documentNumber, roleId);

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
            var session = base.CurrentSession;
            var roleId = session.SessionUser.IdRole;
            var documentNumber = session.SessionUser.DocumentNumber;
            var currentAcademicPeriod = _facade.GetCurrentAcademicPeriod();
            var attendanceVsNonAttendanceStatistics = 
                _facade.GetStatistictsAttendanceVsNonAttendance(documentNumber, roleId);

            ViewBag.StatisticsAttendanceVsNonAttendance = attendanceVsNonAttendanceStatistics;
            ViewBag.CurrentAcademicPeriod = currentAcademicPeriod;

            return PartialView();
        }

        public JsonResult GetStatisticsAttendanceVsNonAttendance()
        {
            var session = base.CurrentSession;
            var roleId = session.SessionUser.IdRole;
            var documentNumber = session.SessionUser.DocumentNumber;
            var statistics = _facade.GetStatistictsAttendanceVsNonAttendance(documentNumber, roleId);
            return Json(statistics);
        }

        public ActionResult StatisticsNonAttendancePartial()
        {
            var session = base.CurrentSession;
            var roleId = session.SessionUser.IdRole;
            var documentNumber = session.SessionUser.DocumentNumber;
            var currentAcademicPeriod = _facade.GetCurrentAcademicPeriod();
            var topStatistictAttendanceAndNonAttendanceTeacherCourse =
               _facade.GetTopStatistictAttendanceAndNonAttendanceTeacherCourse(
                   documentNumber, roleId);
            var topStatistictAttendanceAndNonAttendanceStudentCourse =
                _facade.GetTopStatistictAttendanceAndNonAttendanceStudentCourse(
                    documentNumber, roleId);
            var topStatistictsMajorCourseAttendanceAndNonAttendance =
                _facade.GetTopStatistictsMajorCourseAttendanceAndNonAttendance(
                    documentNumber, roleId);

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
            var session = base.CurrentSession;
            var roleId = session.SessionUser.IdRole;
            var documentNumber = session.SessionUser.DocumentNumber;

            var topExcuseClassifications = 
                _facade.GetTopStatistictExcuseClassifications(documentNumber, roleId);
            var statisticsExcuseStatus = _facade.GetStatistictExcuseStatus(documentNumber, roleId);

            ViewBag.TopExcuseClassifications = topExcuseClassifications;
            ViewBag.StatisticsExcuseStatus = statisticsExcuseStatus;

            return PartialView();
        }

        public JsonResult GetStatisticsExcusesStatus()
        {
            var session = base.CurrentSession;
            var roleId = session.SessionUser.IdRole;
            var documentNumber = session.SessionUser.DocumentNumber;

            var statistics = _facade.GetStatistictExcuseStatus(documentNumber, roleId);
            return Json(statistics);
        }
        #endregion Methods
    }
}
