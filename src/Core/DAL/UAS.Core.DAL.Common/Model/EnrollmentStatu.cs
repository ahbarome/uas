//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace UAS.Core.DAL.Common.Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class EnrollmentStatu
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public EnrollmentStatu()
        {
            this.Enrollments = new HashSet<Enrollment>();
        }
    
        public int Id { get; set; }
        public string Name { get; set; }
        public string Observation { get; set; }
        public Nullable<System.DateTime> RegisterDate { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Enrollment> Enrollments { get; set; }
    }
}
