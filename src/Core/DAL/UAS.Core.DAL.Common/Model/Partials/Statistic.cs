using System.Collections.Generic;

namespace UAS.Core.DAL.Common.Model
{
    public partial class Statistic
    {
        public int Id { get; set; }
        public string Description { get; set; }
        public Dictionary<string, int> Summary { get; set; }
    }
}
