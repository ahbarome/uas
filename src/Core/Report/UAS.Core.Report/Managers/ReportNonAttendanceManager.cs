using System.Collections.Generic;
using System.Linq;
using UAS.Core.DAL.Common.Model;
using UAS.Core.DAL.Parsers;
using UAS.Core.DAL.Persisters;

namespace UAS.Core.Report.Managers
{
    internal class ReportNonAttendanceManager
    {
        private NonAttendancePersister _nonAttendancePersister;

        public ReportNonAttendanceManager() {
            _nonAttendancePersister = new NonAttendancePersister();
        }

        internal List<NonAttendanceView> GetNonAttendance(int documentNumber, int roleId)
        {
            var currentRole = ModelEnumParser.RoleParser(roleId);

            var nonAttendanceBase = _nonAttendancePersister.GetNonAttendance();

            if (currentRole == DAL.Common.Model.Enums.Role.ADMIN || currentRole == DAL.Common.Model.Enums.Role.DIRECTOR)
            {
                return nonAttendanceBase.ToList(); ;
            }

            return nonAttendanceBase.Where(
                filter => filter.DocumentNumber == documentNumber).ToList();
        }
    }
}
