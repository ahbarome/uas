namespace UAS.Core.DAL.Common.Model.Enums
{
    public enum Role
    {
        ADMIN = 1,
        DIRECTOR = 2,
        TEACHER = 3,
        STUDENT = 4
    };

    public enum Status
    {
        PENDING = 1,
        ACCCEPTED = 2,
        REQUIRED_CHANGES = 3,
        REJECTED = 4
    };
}
