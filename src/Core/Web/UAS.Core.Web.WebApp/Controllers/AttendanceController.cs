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
            ViewBag.StudentMovements = _facade.Get();
            ViewData.Add(ConfigurationManager.SESSION_KEY, session);
            return View();
        }

        public ActionResult VirtualTeachersClassRoom()
        {
            var session = base.CurrentSession;
            ViewBag.TeacherMovements = _facade.Get();
            ViewData.Add(ConfigurationManager.SESSION_KEY, session);
            return View();
        }

        [HttpPost]
        public JsonResult GetMovements()
        {
            var movements = _facade.Get();
            return Json(movements);
        }
    }
}