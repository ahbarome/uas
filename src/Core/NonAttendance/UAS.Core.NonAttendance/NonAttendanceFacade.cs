using System;
using System.Collections.Generic;
using System.Linq;
using UAS.Core.DAL.Common.Model;
using UAS.Core.NonAttendance.Managers;

namespace UAS.Core.NonAttendance
{
    public class NonAttendanceFacade
    {
        private PersonManager _personManager;
        private ExcuseManager _excuseManager;

        public NonAttendanceFacade()
        {
            _personManager = new PersonManager();
            _excuseManager = new ExcuseManager();
        }

        public List<NonAttendanceRegisterView> GetNonAttendancePendingForExcuse(int documentNumber, int roleId)
        {
            return _personManager.GetNonAttendancePendingForExcuse(documentNumber, roleId);
        }

        public IQueryable<Classification> GetExcuseClassifications()
        {
            return _excuseManager.GetExcuseClassifications();
        }

        public void SaveExcuse(Excuse excuse)
        {
            _excuseManager.Save(excuse);
        }
    }
}
