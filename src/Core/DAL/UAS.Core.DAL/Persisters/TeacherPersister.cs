using System;
using System.Linq;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.DAL.Persisters
{
    public class TeacherPersister : BaseContext
    {
        public Teacher GetTeacherByDocumentNumber(int teacherDocumentNumber)
        {
            var teacher = base.Entities.Teachers.Where(currentTeacher => currentTeacher.DocumentNumber == teacherDocumentNumber).FirstOrDefault();
            return teacher;
        }
    }
}
