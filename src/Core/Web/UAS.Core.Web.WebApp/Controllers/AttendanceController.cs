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

        public ActionResult VirtualStudentsClassRoom()
        {
            var session = base.CurrentSession;
            var course = _facade.GetCourseByTeacherId(session.SessionUser.IdUser);
            var teacher = _facade.GetTeacherById(session.SessionUser.IdUser);
            var statistics = _facade.GetStatisticsByCourseAndTeacherId(course.Id, session.SessionUser.IdUser);
            var studentMovements = _facade.GetAllStudentMovementsWithoutNotificationsByTeacherId(session.SessionUser.IdUser);

            ViewBag.Teacher = teacher;
            ViewBag.Course = course;
            ViewBag.Statistics = statistics;
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

        public ActionResult VirtualTeachersClassRoom()
        {
            var session = base.CurrentSession;
            ViewData.Add(ConfigurationManager.SESSION_KEY, session);
            return View();
        }

        [HttpPost]
        public JsonResult GetMovements()
        {
            var movements = _facade.GetAllMovementsWithoutNotifications();
            return Json(movements);
        }
    }
}