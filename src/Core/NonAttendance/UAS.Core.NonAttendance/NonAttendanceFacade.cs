using System;
using System.Collections.Generic;
using System.Linq;
using UAS.Core.DAL.Common.Model;
using UAS.Core.NonAttendance.Managers;

namespace UAS.Core.NonAttendance
{
    public class NonAttendanceFacade
    {
        private NonAttendanceManager _nonAttendanceManager;
        private ExcuseManager _excuseManager;

        public NonAttendanceFacade()
        {
            _nonAttendanceManager = new NonAttendanceManager();
            _excuseManager = new ExcuseManager();
        }

        public List<NonAttendanceView> GetNonAttendancePendingForExcuse(int documentNumber, int roleId)
        {
            return _nonAttendanceManager.GetNonAttendances(documentNumber, roleId);
        }

        public IQueryable<Classification> GetExcuseClassifications()
        {
            return _excuseManager.GetExcuseClassifications();
        }

        public void SaveExcuse(Excuse excuse)
        {
            _excuseManager.Save(excuse);
        }

        public List<ExcuseApprovalView> GetExcusesForApproval(int documentNumber, int roleId)
        {
            return _excuseManager.GetExcusesForApproval(documentNumber, roleId);
        }

        public ExcuseApprovalView GetExcuseForApproval(int idExcuse)
        {
            return _excuseManager.GetExcuseForApproval(idExcuse);
        }

        public List<Attachment> GetAttachments(int idExcuse)
        {
            return _excuseManager.GetAttachments(idExcuse);
        }
    }
}
