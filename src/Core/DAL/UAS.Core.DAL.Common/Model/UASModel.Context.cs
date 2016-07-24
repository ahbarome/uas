﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace UAS.Core.DAL.Common.Model
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class UASEntities : DbContext
    {
        public UASEntities()
            : base("name=UASEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Role> Roles { get; set; }
        public virtual DbSet<User> Users { get; set; }
        public virtual DbSet<Page> Pages { get; set; }
        public virtual DbSet<PagePermissionByRole> PagePermissionByRoles { get; set; }
        public virtual DbSet<Movement> Movements { get; set; }
        public virtual DbSet<AcademicPeriod> AcademicPeriods { get; set; }
        public virtual DbSet<Career> Careers { get; set; }
        public virtual DbSet<Course> Courses { get; set; }
        public virtual DbSet<Enrollment> Enrollments { get; set; }
        public virtual DbSet<EnrollmentStatu> EnrollmentStatus { get; set; }
        public virtual DbSet<Fringe> Fringes { get; set; }
        public virtual DbSet<HolidayException> HolidayExceptions { get; set; }
        public virtual DbSet<Schedule> Schedules { get; set; }
        public virtual DbSet<ScheduleDetail> ScheduleDetails { get; set; }
        public virtual DbSet<Student> Students { get; set; }
        public virtual DbSet<Teacher> Teachers { get; set; }
        public virtual DbSet<Attachment> Attachments { get; set; }
        public virtual DbSet<Classification> Classifications { get; set; }
        public virtual DbSet<Excuse> Excuses { get; set; }
        public virtual DbSet<ExcuseDetail> ExcuseDetails { get; set; }
        public virtual DbSet<Status> Status { get; set; }
        public virtual DbSet<StatusApproverByRole> StatusApproverByRoles { get; set; }
        public virtual DbSet<EnrollmentDetail> EnrollmentDetails { get; set; }
        public virtual DbSet<StudentEnrollmentView> StudentEnrollmentViews { get; set; }
    
        public virtual ObjectResult<GetAllStudentMovementsByTeacherDocumentNumber_Result> GetAllStudentMovementsByTeacherDocumentNumber(Nullable<int> teacherDocumentNumber)
        {
            var teacherDocumentNumberParameter = teacherDocumentNumber.HasValue ?
                new ObjectParameter("TeacherDocumentNumber", teacherDocumentNumber) :
                new ObjectParameter("TeacherDocumentNumber", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetAllStudentMovementsByTeacherDocumentNumber_Result>("GetAllStudentMovementsByTeacherDocumentNumber", teacherDocumentNumberParameter);
        }
    }
}
