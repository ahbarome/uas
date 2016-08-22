using System;
using System.Collections.Generic;
using UAS.Core.DAL.Common.Model;
using UAS.Core.Report.Managers;

namespace UAS.Core.Report
{
    public class ReportFacade
    {
        private ReportAttendanceManager _attendanceManager;
        private ReportNonAttendanceManager _nonAttendanceManager;

        public ReportFacade() {
            _attendanceManager = new ReportAttendanceManager();
            _nonAttendanceManager = new ReportNonAttendanceManager();
        }

        public List<AttendanceView> GetAttendance(int documentNumber, int roleId) {
            return _attendanceManager.GetAttendance(documentNumber, roleId);
        }

        public List<NonAttendanceView> GetNonAttendance(int documentNumber, int roleId)
        {
            return _nonAttendanceManager.GetNonAttendance(documentNumber, roleId);
        }
    }
}
