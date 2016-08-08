using System;
using System.Web.Mvc;
using UAS.Core.DAL.Common.Model;

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
            var classifications = _facade.GetExcuseClassifications();
            ViewBag.Classifications = classifications;
            ViewBag.NonAttendance = nonAttendance;
            return View();
        }

        public ActionResult PendingExcuseGrid()
        {
            return PartialView();
        }

        public ActionResult ExcuseCreator()
        {
            var classifications = _facade.GetExcuseClassifications();
            ViewBag.Classifications = classifications;
            return PartialView(classifications);
        }

        public JsonResult GetNonAttendancePendingForExcuse()
        {
            var userDocumentNumber = base.CurrentSession.SessionUser.DocumentNumber;
            var roleId = base.CurrentSession.SessionUser.IdRole;
            var nonAttendance = _facade.GetNonAttendancePendingForExcuse(userDocumentNumber, roleId);
            return Json(nonAttendance);
        }

        public JsonResult SaveExcuse(Excuse excuse)
        {
            try
            {
                _facade.SaveExcuse(excuse);
                return Json(new { Success = true, Message = "" });
            }
            catch (Exception exception)
            {
                return Json(new { Success = false, Message = exception.Message });
            }

        }
    }
}