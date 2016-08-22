using System;
using System.Collections.Generic;
using System.Web.Mvc;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.Web.WebApp.Controllers
{
    /// <summary>
    /// Manage all the view and actions for the NonAttendance process
    /// </summary>
    public class NonAttendanceController : SessionController
    {
        #region Attributes
        /// <summary>
        /// 
        /// </summary>
        private Facade.Facade _facade;
        #endregion Attributes

        #region Methods
        public NonAttendanceController()
        {
            _facade = new Facade.Facade();
        }

        #region Excuse creator module
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public ActionResult ExcuseCreator()
        {
            var nonAttendance = GetNonAttendancesPendingForExcuse();
            var classifications = GetExcuseClassifications();
            return View();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public ActionResult PendingExcuseGrid()
        {
            var nonAttendance = GetNonAttendancesPendingForExcuse();
            var classifications = GetExcuseClassifications();
            return PartialView();
        }

        public ActionResult ExcuseCreatorDetail()
        {
            var classifications = GetExcuseClassifications();
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

        private dynamic GetNonAttendancesPendingForExcuse()
        {
            var userDocumentNumber = base.CurrentSession.SessionUser.DocumentNumber;
            var roleId = base.CurrentSession.SessionUser.IdRole;
            var nonAttendance = _facade.GetNonAttendancePendingForExcuse(userDocumentNumber, roleId);
            ViewBag.NonAttendance = nonAttendance;
            return nonAttendance;
        }

        private dynamic GetExcuseClassifications()
        {
            var roleId = base.CurrentSession.SessionUser.IdRole;
            var classifications = _facade.GetExcuseClassifications(roleId);
            ViewBag.Classifications = classifications;
            return classifications;
        }
        #endregion Excuse creator module

        #region Excuse manager module

        public ActionResult ExcuseManager()
        {
            var excuses = GetExcusesForApproval();
            var status = GetExcuseStatus();
            ViewBag.Status = status;
            ViewBag.Excuses = excuses;
            return View();
        }

        public ActionResult ApprovalExcuseGrid()
        {
            var excuses = GetExcusesForApproval();
            ViewBag.Excuses = excuses;
            return PartialView();
        }

        public ActionResult ApprovalExcuseDetail(int idExcuse)
        {
            var excuses = _facade.GetExcusesForApproval(idExcuse);
            var attachments = _facade.GetAttachments(idExcuse);
            ViewBag.Excuses = excuses;
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
            var status = _facade.GetExcuseStatus(roleId);
            ViewBag.Status = status;
            return PartialView();
        }

        public JsonResult ApproveExcuses(List<ExcuseApprovalView> excuses)
        {
            try
            {
                _facade.ApproveExcuses(excuses);
                return Json(new { Success = true, Message = string.Empty });
            }
            catch (Exception exception)
            {
                return Json(new { Success = false, Message = exception.Message });
            }
        }

        private dynamic GetExcusesForApproval()
        {
            var userDocumentNumber = base.CurrentSession.SessionUser.DocumentNumber;
            var roleId = base.CurrentSession.SessionUser.IdRole;
            var excuses = _facade.GetExcusesForApproval(userDocumentNumber, roleId);
            return excuses;
        }

        private dynamic GetExcuseStatus()
        {
            var roleId = base.CurrentSession.SessionUser.IdRole;
            var status = _facade.GetExcuseStatus(roleId);
            return status;
        }
        #endregion Excuse manager module

        #region Excuse verificator module

        public ActionResult ExcuseVerificator()
        {
            const int DEFAULT_EXCUSE = -1;
            var excuses = GetExcuses();
            var excuseApprovals = _facade.GetExcusesForApproval(DEFAULT_EXCUSE);
            var attachments = _facade.GetAttachments(DEFAULT_EXCUSE);
            ViewBag.ExcuseApprovals = excuseApprovals;
            ViewBag.Attachments = attachments;
            return View(excuses);
        }

        public ActionResult ExcuseVerificatorDetail(int idExcuse)
        {
            var excuseApprovals = _facade.GetExcusesForApproval(idExcuse);
            var attachments = _facade.GetAttachments(idExcuse);
            ViewBag.ExcuseApprovals = excuseApprovals;
            ViewBag.Attachments = attachments;
            return PartialView();
        }

        public ActionResult ExcuseVerificatorGrid()
        {
            var excuses = GetExcuses();
            return PartialView();
        }

        private dynamic GetExcuses()
        {
            var userDocumentNumber = base.CurrentSession.SessionUser.DocumentNumber;
            var roleId = base.CurrentSession.SessionUser.IdRole;
            var excuses = _facade.GetExcuses(userDocumentNumber, roleId);
            ViewBag.Excuses = excuses;
            return excuses;
        }

        #endregion Excuse verificator module
        #endregion Methods
    }
}