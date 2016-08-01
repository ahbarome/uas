using System.Web.Mvc;

namespace UAS.Core.Web.WebApp.Controllers
{
    public class NonAttendanceController : SessionController
    {
        private Facade.Facade _facade;

        public NonAttendanceController()
        {
            _facade = new Facade.Facade();
        }

        public ActionResult Excuse()
        {
            var userDocumentNumber = base.CurrentSession.SessionUser.DocumentNumber;
            var roleId = base.CurrentSession.SessionUser.IdRole;
            var nonAttendance = _facade.GetNonAttendancePendingForExcuse(userDocumentNumber, roleId);
            return View(nonAttendance);
        }

        public JsonResult GetNonAttendancePendingForExcuse()
        {
            var userDocumentNumber = base.CurrentSession.SessionUser.DocumentNumber;
            var roleId = base.CurrentSession.SessionUser.IdRole;
            var nonAttendance = _facade.GetNonAttendancePendingForExcuse(userDocumentNumber, roleId);
            return Json(nonAttendance);
        }
    }
}