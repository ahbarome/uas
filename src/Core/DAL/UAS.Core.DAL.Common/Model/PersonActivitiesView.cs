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
    
    public partial class PersonActivitiesView
    {
        public int CourseId { get; set; }
        public string CourseName { get; set; }
        public int DocumentNumber { get; set; }
        public string FullName { get; set; }
        public string ImageRelativePath { get; set; }
        public string RoleId { get; set; }
        public string RoleAlias { get; set; }
        public int SpaceId { get; set; }
        public string SpaceName { get; set; }
        public string SpaceType { get; set; }
        public int DayOfTheWeek { get; set; }
        public System.TimeSpan StartTime { get; set; }
        public System.TimeSpan EndTime { get; set; }
    }
}
