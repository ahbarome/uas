namespace UAS.Core.Session.Entities
{
    public class Page
    {
        public int IdPage { get; set; }
        public bool IsDefault { get; set; }
        public bool IsVisible { get; set; }
        public string MenuItem { get; set; }
        public int? ParentId { get; set; }
        public string Title { get; set; }
        public string IconClass { get; set; }
        public string Controller { get; set; }
        public string Action { get; set; }
    }
}