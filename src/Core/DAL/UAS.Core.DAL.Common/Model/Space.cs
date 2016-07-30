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
    
    public partial class Space
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Space()
        {
            this.Movements = new HashSet<Movement>();
            this.ScheduleDetails = new HashSet<ScheduleDetail>();
        }
    
        public int Id { get; set; }
        public string Name { get; set; }
        public int IdSpaceType { get; set; }
        public Nullable<System.DateTime> RegisterDate { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Movement> Movements { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ScheduleDetail> ScheduleDetails { get; set; }
        public virtual SpaceType SpaceType { get; set; }
    }
}