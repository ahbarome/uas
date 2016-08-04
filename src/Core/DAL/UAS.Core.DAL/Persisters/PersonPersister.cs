using System.Collections.Generic;
using System.Linq;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.DAL.Persisters
{
    public class PersonPersister : BaseContext
    {
        public List<NonAttendanceRegisterView> GetNonAttendancePendingForExcuse(int documentNumber, int roleId)
        {
            var nonAttendance = base.Entities.NonAttendanceRegisterView.Where(
                filter => filter.DocumentNumber == documentNumber && filter.RoleId.Equals(roleId.ToString()))
                .ToList();

            return nonAttendance;
        }
    }
}
