using System.Web.Mvc;

namespace UAS.Core.Web.WebApp.Controllers
{
    public class AttendanceController : SessionController
    {
        public ActionResult VirtualStudentsClassRoom()
        {
            return View();
        }

        public ActionResult VirtualTeachersClassRoom()
        {
            return View();
        }
    }
}