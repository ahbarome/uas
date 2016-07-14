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
            var movements = _facade.GetAllMovementsWithoutNotifications();
            ViewBag.StudentMovements = movements;
            ViewData.Add(ConfigurationManager.SESSION_KEY, session);
            return View(movements);
        }

        public ActionResult VirtualStudentsClassRoomPartial()
        {
            var session = base.CurrentSession;
            var movements = _facade.GetAllMovementsWithoutNotifications();
            ViewBag.StudentMovements = movements;
            ViewData.Add(ConfigurationManager.SESSION_KEY, session);
            return PartialView(movements);
        }

        public ActionResult VirtualTeachersClassRoom()
        {
            var session = base.CurrentSession;
            var movements = _facade.GetAllMovementsWithoutNotifications();
            ViewBag.TeacherMovements = movements;
            ViewData.Add(ConfigurationManager.SESSION_KEY, session);
            return View(movements);
        }

        [HttpPost]
        public JsonResult GetMovements()
        {
            var movements = _facade.GetAllMovementsWithNotifications();
            return Json(movements);
        }
    }
}