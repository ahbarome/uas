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
    
    public partial class ClassificationByRoleView
    {
        public int IdClassification { get; set; }
        public string Classification { get; set; }
        public int IdRole { get; set; }
        public string RoleName { get; set; }
        public string RoleAlias { get; set; }
        public Nullable<bool> IsRequiredDescription { get; set; }
    }
}