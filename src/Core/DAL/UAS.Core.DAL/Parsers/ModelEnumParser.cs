namespace UAS.Core.DAL.Parsers
{
    using System;
    using Common.Model.Enums;
    public class ModelEnumParser
    {
        public static Role RoleParser(int roleId)
        {
            var role = (Role)Enum.Parse(typeof(Role), roleId.ToString());
            return role;
        }

        public static Status StatusParser(int statusId)
        {
            var status = (Status)Enum.Parse(typeof(Status), statusId.ToString());
            return status;
        }

    }
}
