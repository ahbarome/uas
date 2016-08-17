using System;
using System.Web.Mvc;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.Web.WebApp.Controllers
{
    public class NonAttendanceController : SessionController
    {
        /// <summary>
        /// 
        /// </summary>
        private Facade.Facade _facade;

        public NonAttendanceController()
        {
            _facade = new Facade.Facade();
        }

        #region Excuse creator module
        public ActionResult ExcuseCreator()
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
            var userDocumentNumber = base.CurrentSession.SessionUser.DocumentNumber;
            var roleId = base.CurrentSession.SessionUser.IdRole;
            var nonAttendance = _facade.GetNonAttendancePendingForExcuse(userDocumentNumber, roleId);
            var classifications = _facade.GetExcuseClassifications();
            ViewBag.Classifications = classifications;
            ViewBag.NonAttendance = nonAttendance;
            return PartialView();
        }

        public ActionResult ExcuseCreatorDetail()
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
                excuse.IdRole = base.CurrentSession.SessionUser.IdRole;
                excuse.DocumentNumber = base.CurrentSession.SessionUser.DocumentNumber;
                _facade.SaveExcuse(excuse);
                return Json(new { Success = true, Message = string.Empty });
            }
            catch (Exception exception)
            {
                return Json(new { Success = false, Message = exception.Message });
            }

        }
        #endregion Excuse creator module

        #region Excuse manager

        public ActionResult ExcuseManager()
        {
            var userDocumentNumber = base.CurrentSession.SessionUser.DocumentNumber;
            var roleId = base.CurrentSession.SessionUser.IdRole;
            var excuses = _facade.GetExcusesForApproval(userDocumentNumber, roleId);
            var status = _facade.GetExcuseStatus();
            ViewBag.Status = status;
            ViewBag.Excuses = excuses;
            return View();
        }


        public ActionResult ApprovalExcuseGrid()
        {
            var userDocumentNumber = base.CurrentSession.SessionUser.DocumentNumber;
            var roleId = base.CurrentSession.SessionUser.IdRole;
            var excuses = _facade.GetExcusesForApproval(userDocumentNumber, roleId);
            ViewBag.Excuses = excuses;
            return PartialView();
        }

        public ActionResult ApprovalExcuseDetail(int idExcuse)
        {
            var userDocumentNumber = base.CurrentSession.SessionUser.DocumentNumber;
            var excuse = _facade.GetExcuseForApproval(idExcuse);
            var attachments = _facade.GetAttachments(idExcuse);
            ViewBag.Excuse = excuse;
            ViewBag.Attachments = attachments;
            return PartialView();
        }

        public ActionResult ApprovalExcuse()
        {
            var userDocumentNumber = base.CurrentSession.SessionUser.DocumentNumber;
            var roleId = base.CurrentSession.SessionUser.IdRole;
            var excuses = _facade.GetExcusesForApproval(userDocumentNumber, roleId);
            ViewBag.Excuses = excuses;
            return PartialView();
        }

        public ActionResult ApprovalExcuseStatusChanger()
        {
            var userDocumentNumber = base.CurrentSession.SessionUser.DocumentNumber;
            var roleId = base.CurrentSession.SessionUser.IdRole;
            var status = _facade.GetExcuseStatus();
            ViewBag.Status = status;
            return PartialView();
        }

        public JsonResult ApproveExcuse(ExcuseApprovalView excuse) {
            try {
                _facade.ApproveExcuse(excuse);
                return Json(new { Success = true, Message = string.Empty });
            }
            catch (Exception exception)
            {
                return Json(new { Success = false, Message = exception.Message });
            }
        }
        #endregion Excuse manager
    }
}