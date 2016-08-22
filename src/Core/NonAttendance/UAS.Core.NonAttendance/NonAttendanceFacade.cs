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

        public IQueryable<ClassificationByRoleView> GetExcuseClassifications(int roleId)
        {
            return _excuseManager.GetExcuseClassifications(roleId);
        }

        public void SaveExcuse(Excuse excuse)
        {
            _excuseManager.Save(excuse);
        }

        public List<ExcuseApprovalView> GetExcusesForApproval(int documentNumber, int roleId)
        {
            return _excuseManager.GetExcusesForApproval(documentNumber, roleId);
        }

        public List<ExcuseApprovalView> GetExcusesForApproval(int idExcuse)
        {
            return _excuseManager.GetExcusesForApproval(idExcuse);
        }

        public ExcuseApprovalView GetExcuseForApproval(int idExcuse)
        {
            return _excuseManager.GetExcuseForApproval(idExcuse);
        }

        public List<Attachment> GetAttachments(int idExcuse)
        {
            return _excuseManager.GetAttachments(idExcuse);
        }

        public List<StatusByRoleView> GetExcuseStatus(int roleId)
        {
            return _excuseManager.GetExcuseStatus(roleId);
        }

        public void ApproveExcuses(List<ExcuseApprovalView> excuses)
        {
            _excuseManager.ApproveExcuses(excuses);
        }

        public List<ExcuseView> GetExcuses(int documentNumber, int roleId)
        {
            return _excuseManager.GetExcuses(documentNumber, roleId);
        }
    }
}
