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
    
    public partial class NonAttendance
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public NonAttendance()
        {
            this.Excuses = new HashSet<Excuse>();
        }
    
        public int Id { get; set; }
        public int DocumentNumber { get; set; }
        public int IdRole { get; set; }
        public int IdCourse { get; set; }
        public int IdSpace { get; set; }
        public int DayOfTheWeek { get; set; }
        public System.TimeSpan StartTime { get; set; }
        public System.TimeSpan EndTime { get; set; }
        public System.DateTime NonAttendanceDate { get; set; }
        public bool HasExcuse { get; set; }
        public Nullable<System.DateTime> RegisterDate { get; set; }
    
        public virtual Course Course { get; set; }
        public virtual Space Space { get; set; }
        public virtual Role Role { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Excuse> Excuses { get; set; }
    }
}
