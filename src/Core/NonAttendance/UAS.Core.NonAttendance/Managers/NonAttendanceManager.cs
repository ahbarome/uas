using System;
using System.Collections.Generic;
using UAS.Core.DAL.Persisters;

namespace UAS.Core.NonAttendance.Managers
{
    internal class NonAttendanceManager
    {
        private NonAttendancePersister _nonAttendancePersister;
        public NonAttendanceManager()
        {
            _nonAttendancePersister = new NonAttendancePersister();
        }

        internal List<DAL.Common.Model.NonAttendanceView> GetNonAttendances(int documentNumber, int roleId)
        {
            return _nonAttendancePersister.GetNonAttendances(documentNumber, roleId);
        }

        internal void UpdateHasExcuse(int id, bool hasExcuse)
        {
            _nonAttendancePersister.UpdateHasExcuse(id, hasExcuse);
        }
    }
}
