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
            var course = teacher != null ? _facade.GetCurrentCourseByTeacherDocumentNumber(teacher.DocumentNumber) : null;
            var studentMovements = _facade.GetAllStudentMovementsWithoutNotificationsByTeacherId(session.SessionUser.IdUser);
            var statistics = course != null ? _facade.GetCourseStatistics(course.Id) : null;
            var attendanceStatistics = teacher != null ? _facade.GetCourseAttendanceStatistics(teacher.DocumentNumber) : null;

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

        public ActionResult CourseDetailPartial()
        {
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
            var teacherMovements = _facade.GetAllTeacherMovementsWithoutNotificationsByDirectorId(session.SessionUser.IdUser);
            var attendanceStatistics = _facade.GetTeacherAttendanceStatistics();

            ViewBag.AttendanceStatistic = attendanceStatistics;
            ViewData.Add(ConfigurationManager.SESSION_KEY, session);
            return View(teacherMovements);
        }

        public ActionResult VirtualTeachersClassRoomPartial()
        {
            var session = base.CurrentSession;
            var teacherMovements = _facade.GetAllTeacherMovementsWithoutNotificationsByDirectorId(session.SessionUser.IdUser);

            ViewData.Add(ConfigurationManager.SESSION_KEY, session);
            return PartialView(teacherMovements);
        }

        public ActionResult DirectorProfilePartial()
        {
            return PartialView();
        }

        public ActionResult TeacherStatisticPartial()
        {
            var session = base.CurrentSession;
            //var statistics = _facade.GetTeacherStatistics();
            //ViewBag.TeacherStatistic = statistics;
            return PartialView();
        }

        public ActionResult TeacherAttendanceStatisticPartial()
        {
            var session = base.CurrentSession;
            var attendanceStatistics = _facade.GetTeacherAttendanceStatistics();

            ViewBag.AttendanceStatistic = attendanceStatistics;
            return PartialView();
        }

        public ActionResult TeacherAttendanceGraphPartial()
        {
            var session = base.CurrentSession;
            var attendanceStatistics = _facade.GetTeacherAttendanceStatistics();

            ViewBag.AttendanceStatistic = attendanceStatistics;
            return PartialView();
        }

        #endregion Virtual Teachers Class Room

        [HttpPost]
        public JsonResult GetCurrentStudentStatistics()
        {
            var session = base.CurrentSession;
            var teacher = _facade.GetTeacherById(session.SessionUser.IdUser);
            var attendance = _facade.GetCourseAttendanceStatistics(teacher.DocumentNumber);
            return Json(attendance);
        }

        [HttpPost]
        public JsonResult GetCurrentTeacherStatistics()
        {
            var session = base.CurrentSession;
            var attendance = _facade.GetTeacherAttendanceStatistics();
            return Json(attendance);
        }
        #endregion Actions
    }
}