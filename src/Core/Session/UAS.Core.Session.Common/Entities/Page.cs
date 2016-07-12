namespace UAS.Core.Session.Entities
{
    public class Page
    {
        public bool IsDefault { get; set; }
        public bool IsVisible { get; set; }
        public string MenuItem { get; set; }
        public int? ParentId { get; set; }
        public string Title { get; set; }
    }
}