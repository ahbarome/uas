namespace UAS.Core.DAL.Common.Model
{
    public partial class TeacherMovement : Movement
    {
        public int CourseId { get; set; }
        public string CourseName { get; set; }
        public System.TimeSpan CourseStartTime { get; set; }
        public System.TimeSpan CourseEndTime { get; set; }
    }
}
