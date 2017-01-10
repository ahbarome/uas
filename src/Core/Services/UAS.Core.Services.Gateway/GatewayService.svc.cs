using log4net;
using System;
using System.Data.Entity.Core.EntityClient;
using System.Data.SqlClient;
using UAS.Core.Attendance;
using UAS.Core.Attendance.Interfaces;
using UAS.Core.Configuration;
using UAS.Core.DTO.Entities;

namespace UAS.Core.Services.Gateway
{
    public class GatewayService : IGatewayService
    {
        /// <summary>
        /// Logger for the service
        /// </summary>
        private static readonly ILog _logger =
            LogManager.GetLogger(
                System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

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
        /// <param name="movement">Data of the movement</param>
        public void GenerateMovement(MovementDTO movement)
        {
            try
            {
                _facade.GenerateMovement(movement);
            }
            catch (Exception exception) {
                _logger.Error(exception.Message, exception);
                throw exception;
            }
            
        }

        /// <summary>
        /// Get all the availables spaces
        /// </summary>
        /// <returns></returns>
        public SpaceDTOCollection GetAvailablesSpaces()
        {
            try
            {
                return _facade.GetAvailableSpacesForMovements();
            }
            catch (Exception exception) {
                _logger.Error(exception.Message, exception);
                throw exception;
            }

        }
    }
}
