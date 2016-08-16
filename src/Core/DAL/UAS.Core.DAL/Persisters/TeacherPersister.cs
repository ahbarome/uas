using System;
using System.Collections.Generic;
using System.Linq;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.DAL.Persisters
{
    public class TeacherPersister : PersonPersister
    {
        public Teacher GetTeacherByDocumentNumber(int teacherDocumentNumber)
        {
            var teacher = base.Entities.Teachers.Where(currentTeacher => currentTeacher.DocumentNumber == teacherDocumentNumber).FirstOrDefault();
            return teacher;
        }

        public Statistic GetTeacherAttendanceStatistics()
        {
            var todayTeacherAttendance = base.Entities.GetCurrentTeacherAttendanceSummary();

            var statistic = new Statistic { Summary = new Dictionary<string, int>() };

            foreach (var attendance in todayTeacherAttendance)
            {
                if (statistic.Summary.ContainsKey(attendance.Alias))
                {
                    statistic.Summary[attendance.Alias] +=
                        statistic.Summary[attendance.Alias] + attendance.Total ?? 0;
                }
                else
                {
                    statistic.Summary.Add(attendance.Alias, attendance.Total ?? 0);
                }
            }

            return statistic;
        }
    }
}
