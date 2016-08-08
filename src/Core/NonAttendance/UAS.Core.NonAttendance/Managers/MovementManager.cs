using System.Collections.Generic;
using UAS.Core.DAL.Common.Model;
using UAS.Core.DAL.Persisters;

namespace UAS.Core.NonAttendance.Managers
{
    internal class PersonManager
    {
        private PersonPersister _personPersister;
        public PersonManager()
        {
            _personPersister = new PersonPersister();
        }

        public List<NonAttendanceRegisterView> GetNonAttendancePendingForExcuse(int documentNumber, int roleId)
        {
            return _personPersister.GetNonAttendancePendingForExcuse(documentNumber, roleId);
        }
    }
}
