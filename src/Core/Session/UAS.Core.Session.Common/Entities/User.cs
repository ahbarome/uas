using System.Collections.Generic;

namespace UAS.Core.Session.Entities
{
    public class User
    {
        public int IdRole { get; set; }
        public int IdUser { get; set; }
        public int DocumentNumber { get; set; }
        public bool IsActive { get; set; }
        public string Name { get; set; }
        public string LastName { get; set; }
        public string FullName { get; set; }
        public string Password { get; set; }
        public string Username { get; set; }
        public string RoleName { get; set; }
        public string ImageRelativePath { get; set; }
        public List<Page> Pages { get; set; }
    }
}