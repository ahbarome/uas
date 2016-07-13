using System.Web.Mvc;
using UAS.Core.Configuration;

namespace UAS.Core.Web.WebApp.Controllers
{
    public class AttendanceController : SessionController
    {
        public ActionResult VirtualStudentsClassRoom()
        {
            var session = base.CurrentSession;
            ViewData.Add(ConfigurationManager.SESSION_KEY, session);
            return View();
        }

        public ActionResult VirtualTeachersClassRoom()
        {
            return View();
        }

        [HttpPost]
        public JsonResult GetMovements()
        {
            return Json(new { IdUser = "1", Date = System.DateTime.Now });
        }
    }
}