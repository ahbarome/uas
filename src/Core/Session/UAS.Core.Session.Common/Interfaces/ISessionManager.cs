namespace UAS.Core.Session.Interfaces
{
    using Entities;

    public interface ISessionManager
    {
        Session GetSession();
        void CreateSession(string username, string password);
        void CloseSession();
    }
}
