using System.Data.Entity.Core.EntityClient;
using System.Data.SqlClient;
using UAS.Core.Attendance;
using UAS.Core.Attendance.Interfaces;
using UAS.Core.Configuration;

namespace UAS.Core.Services.Gateway
{
    public class GatewayService : IGatewayService
    {
        /// <summary>
        /// Facade for all the related with the movements
        /// </summary>
        private static IAttendanceFacade _facade;
        
        /// <summary>
        /// Builder for the connection string
        /// </summary>
        private static EntityConnectionStringBuilder _entityConnectionString =
            new EntityConnectionStringBuilder(ConfigurationManager.ConnectionStringUASEntites);

        /// <summary>
        /// Connection string for the database
        /// </summary>
        private static string _connectionString = _entityConnectionString.ProviderConnectionString;

        /// <summary>
        /// Builder method
        /// </summary>
        public GatewayService()
        {
            if (_facade == null)
            {
                SqlDependency.Start(_connectionString);
#if (DEBUG)
                _facade = new AttendanceFacadeStub();
#else
                _facade = new AttendanceFacade();
#endif

            }
        }

        /// <summary>
        /// Destructur method
        /// </summary>
        ~GatewayService()
        {
            if (_facade != null)
            {
                SqlDependency.Stop(_connectionString);
            }
        }

        /// <summary>
        /// Test method to test the connection with the service
        /// </summary>
        /// <param name="id">Any parameter identifier for the test</param>
        /// <returns>Default message</returns>
        public string JSONData(string id)
        {
            return "Message " + id;
        }

        /// <summary>
        /// Call the routine to persist the movement
        /// </summary>
        /// <param name="JSONMovementDTO">JSON with the data of the movement</param>
        public void GenerateMovement(string JSONMovementDTO)
        {
            _facade.GenerateMovement(JSONMovementDTO);
        }

        /// <summary>
        /// Get all the availables spaces
        /// </summary>
        /// <returns></returns>
        public string GetAvailablesSpaces()
        {
            return _facade.GetAvailableSpacesForMovements();
        }
    }
}
