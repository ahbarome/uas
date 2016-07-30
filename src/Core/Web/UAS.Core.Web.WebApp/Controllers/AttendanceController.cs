using System.Web.Mvc;
using UAS.Core.Configuration;

namespace UAS.Core.Web.WebApp.Controllers
{
    using Facade;

    public class AttendanceController : SessionController
    {
        private Facade _facade;

        public AttendanceController()
        {
            _facade = new Facade();
        }
        #region Actions
        #region Virtual Students Class Room
        public ActionResult VirtualStudentsClassRoom()
        {
            var session = base.CurrentSession;
            var teacher = _facade.GetTeacherById(session.SessionUser.IdUser);
            var course = _facade.GetCurrentCourseByTeacherDocumentNumber(teacher.DocumentNumber);
            var studentMovements = _facade.GetAllStudentMovementsWithoutNotificationsByTeacherId(session.SessionUser.IdUser);
            var statistics = _facade.GetCourseStatistics(course.Id);
            var attendanceStatistics = _facade.GetCourseAttendanceStatistics(teacher.DocumentNumber);

            ViewBag.CourseAttendanceStatistic = attendanceStatistics;
            ViewBag.CourseStatistic = statistics;
            ViewBag.Teacher = teacher;
            ViewBag.Course = course;
            ViewData.Add(ConfigurationManager.SESSION_KEY, session);

            return View(studentMovements);
        }

        public ActionResult VirtualStudentsClassRoomPartial()
        {
            var session = base.CurrentSession;
            var movements = _facade.GetAllStudentMovementsWithoutNotificationsByTeacherId(session.SessionUser.IdUser);
            ViewData.Add(ConfigurationManager.SESSION_KEY, session);
            return PartialView(movements);
        }


        public ActionResult CourseDetailPartial() {
            var session = base.CurrentSession;
            var teacher = _facade.GetTeacherById(session.SessionUser.IdUser);
            var course = _facade.GetCurrentCourseByTeacherDocumentNumber(teacher.DocumentNumber);
            ViewBag.Teacher = teacher;
            ViewBag.Course = course;
            return PartialView();
        }

        public ActionResult CourseStatisticPartial()
        {
            var session = base.CurrentSession;
            var teacher = _facade.GetTeacherById(session.SessionUser.IdUser);
            var course = _facade.GetCurrentCourseByTeacherDocumentNumber(teacher.DocumentNumber);
            var statistics = _facade.GetCourseStatistics(course.Id);
            ViewBag.CourseStatistic = statistics;
            return PartialView();
        }

        public ActionResult CourseAttendanceStatisticPartial()
        {
            var session = base.CurrentSession;
            var teacher = _facade.GetTeacherById(session.SessionUser.IdUser);
            var course = _facade.GetCurrentCourseByTeacherDocumentNumber(teacher.DocumentNumber);
            var attendanceStatistics = _facade.GetCourseAttendanceStatistics(teacher.DocumentNumber);

            ViewBag.CourseAttendanceStatistic = attendanceStatistics;
            return PartialView();
        }

        public ActionResult CourseAttendanceGraphPartial()
        {
            var session = base.CurrentSession;
            var teacher = _facade.GetTeacherById(session.SessionUser.IdUser);
            var attendanceStatistics = _facade.GetCourseAttendanceStatistics(teacher.DocumentNumber);

            ViewBag.CourseAttendanceStatistic = attendanceStatistics;
            return PartialView();
        }


        #endregion Virtual Students Class Room

        #region Virtual Teachers Class Room
        public ActionResult VirtualTeachersClassRoom()
        {
            var session = base.CurrentSession;
            ViewData.Add(ConfigurationManager.SESSION_KEY, session);
            return View();
        }

        #endregion Virtual Teachers Class Room

        [HttpPost, ActionName("GetStatistics")]
        public JsonResult GetCourseAttendanceStatistics()
        {
            var session = base.CurrentSession;
            var teacher = _facade.GetTeacherById(session.SessionUser.IdUser);
            var courseAttendance = _facade.GetCourseAttendanceStatistics(teacher.DocumentNumber);
            return Json(courseAttendance);
        }
        #endregion Actions
    }
}