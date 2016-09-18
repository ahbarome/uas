using log4net;
using System.Collections.Generic;
using UAS.Core.DAL.Common.Model;
using UAS.Core.Report.Managers;

namespace UAS.Core.Report
{
    public class ReportFacade
    {
        /// <summary>
        /// Logger for the report facade
        /// </summary>
        private static readonly ILog _logger =
            LogManager.GetLogger(
                System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        private ReportAttendanceManager _attendanceManager;
        private ReportNonAttendanceManager _nonAttendanceManager;

        public ReportFacade() {
            _attendanceManager = new ReportAttendanceManager();
            _nonAttendanceManager = new ReportNonAttendanceManager();
        }

        public List<AttendanceView> GetAttendance(int documentNumber, int roleId) {
            var attendance = _attendanceManager.GetAttendance(documentNumber, roleId);
            attendance.ForEach(register => _logger.Info(register));
            return attendance;
        }

        public List<NonAttendanceView> GetNonAttendance(int documentNumber, int roleId)
        {
            var nonAttendance = _nonAttendanceManager.GetNonAttendance(documentNumber, roleId);
            nonAttendance.ForEach(register => _logger.Info(register));
            return nonAttendance;
        }
    }
}
