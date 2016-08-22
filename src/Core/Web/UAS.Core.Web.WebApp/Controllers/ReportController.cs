using System.Web.Mvc;

namespace UAS.Core.Web.WebApp.Controllers
{
    /// <summary>
    /// Manage all the reports
    /// </summary>
    public class ReportController : SessionController
    {
        #region Attributes
        /// <summary>
        /// 
        /// </summary>
        private Facade.Facade _facade;
        #endregion Attributes

        #region Methods

        /// <summary>
        /// Builder method
        /// </summary>
        public ReportController() {
            _facade = new Facade.Facade();
        }

        #region Report attendance module
        /// <summary>
        /// Retreive the view for the report with
        /// all the attendance
        /// </summary>
        /// <returns>View with the attendance</returns>
        public ActionResult ReportAttendance()
        {
            var attendance = GetAttendance();
            return View(attendance);
        }

        /// <summary>
        /// Retreive the partial view with the data
        /// of all the attendance
        /// </summary>
        /// <returns></returns>
        public ActionResult ReportAttendanceGrid() {
            return PartialView();
        }

        /// <summary>
        /// Get the attendance base on the document number
        /// and role of the current user
        /// </summary>
        /// <returns>Attendance</returns>
        private dynamic GetAttendance() {
            var documentNumber = base.CurrentSession.SessionUser.DocumentNumber;
            var roleId = base.CurrentSession.SessionUser.IdRole;
            var attendance = _facade.GetAttendance(documentNumber, roleId);
            return attendance;
        }
        #endregion Report attendance module

        #region Report nonattendance module
        /// <summary>
        /// Retreive the view for the report with
        /// all the nonattendance
        /// </summary>
        /// <returns>View with the attendance</returns>
        public ActionResult ReportNonAttendance()
        {
            var nonAttendance = GetNonAttendance();
            return View(nonAttendance);
        }

        /// <summary>
        /// Retreive the partial view with the data
        /// of all the nonattendance
        /// </summary>
        /// <returns></returns>
        public ActionResult ReportNonAttendanceGrid()
        {
            return PartialView();
        }

        private dynamic GetNonAttendance() {
            var documentNumber = base.CurrentSession.SessionUser.DocumentNumber;
            var roleId = base.CurrentSession.SessionUser.IdRole;
            var nonattendance = _facade.GetNonAttendance(documentNumber, roleId);
            return nonattendance;
        }
        #endregion Report nonattendance module

        #endregion Methods

    }
}