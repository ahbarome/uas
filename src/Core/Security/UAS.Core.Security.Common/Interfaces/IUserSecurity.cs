namespace UAS.Core.Security.Interfaces
{
    public interface IUserSecurity
    {
        void Validate(string username, string password);
    }
}
