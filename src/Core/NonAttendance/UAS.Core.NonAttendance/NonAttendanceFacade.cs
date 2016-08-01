using System;
using System.Collections.Generic;
using UAS.Core.DAL.Common.Model;
using UAS.Core.NonAttendance.Managers;

namespace UAS.Core.NonAttendance
{
    public class NonAttendanceFacade
    {
        private PersonManager _personManager;
        public NonAttendanceFacade()
        {
            _personManager = new PersonManager();
        }

        public List<NonAttendanceRegisterView> GetNonAttendancePendingForExcuse(int documentNumber, int roleId)
        {
            return _personManager.GetNonAttendancePendingForExcuse(documentNumber, roleId);
        }
    }
}
