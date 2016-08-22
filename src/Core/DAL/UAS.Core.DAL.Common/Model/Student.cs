//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class Student
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Student()
        {
            this.Enrollments = new HashSet<Enrollment>();
        }
    
        public int DocumentNumber { get; set; }
        public int Code { get; set; }
        public string Name { get; set; }
        public string LastName { get; set; }
        public int IdCareer { get; set; }
        public int IdFringe { get; set; }
        public Nullable<System.DateTime> RegisterDate { get; set; }
        public string Email { get; set; }
        public Nullable<int> TelephoneNumber { get; set; }
        public string Address { get; set; }
        public string ImageRelativePath { get; set; }
    
        public virtual Career Career { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Enrollment> Enrollments { get; set; }
        public virtual Fringe Fringe { get; set; }
    }
}
