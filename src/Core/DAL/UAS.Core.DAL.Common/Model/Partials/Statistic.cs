﻿using System.Collections.Generic;

namespace UAS.Core.DAL.Common.Model
{
    public partial class Statistic
    {
        public int Id { get; set; }
        public string EventType { get; set; }
        public string EventTypeAlias { get; set; }
        public string Description { get; set; }
        public string AdditionalDescription { get; set; }
        public string ImageRelativePath { get; set; }
        public int Total { get; set; }
        public decimal Percentage { get; set; }
        public Dictionary<string, int> Summary { get; set; }
    }
}
