namespace UAS.Core.DAL.Common.Model
{
    public partial class NonAttendanceView
    {
        public override string ToString()
        {
            var nonAttendanceView =
                string.Format(
                    "{0}, {1}, {2}, {3}, {4}, {5}, {6}, {7}, {8}, {9}, {10}",
                    this.Id,
                    this.DocumentNumber,
                    this.FullName,
                    this.RoleAlias,
                    this.CourseId,
                    this.CourseName,
                    this.SpaceName,
                    this.SpaceType,
                    this.DayOfTheWeek,
                    this.HasExcuse,
                    this.NonAttendanceDate);
            return nonAttendanceView;
        }
    }
}
