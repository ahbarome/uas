using System;

namespace UAS.Core.Configuration
{
    public static class ConfigurationManager
    {
        public const string SESSION_KEY = "USER_SESSION_KEY";

        public const string SECURITY_KEY = "USER_SESSION_KEY";

        public static string ConnectionStringUASEntites
        {
            get
            {
                return GetConnectionString("UASEntities");
            }
        }

        private static string GetConnectionString(string key)
        {
            var connectionString = System.Configuration.ConfigurationManager.ConnectionStrings[key].ConnectionString;
            return connectionString;
        }
    }
}
