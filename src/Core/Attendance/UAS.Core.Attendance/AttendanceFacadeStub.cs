using System.Collections.Generic;
using UAS.Core.Attendance.Interfaces;
using UAS.Core.DTO.Entities;

namespace UAS.Core.Attendance
{
    public class AttendanceFacadeStub : IAttendanceFacade
    {
        public void GenerateMovement(MovementDTO movementDTO)
        {
            return;
        }

        public SpaceDTOCollection GetAvailableSpacesForMovements()
        {
            var spaces = new List<SpaceDTO>
            {
                new SpaceDTO {  IdSpace = 10000, SpaceName ="301", SpaceType ="Salón" },
                new SpaceDTO {  IdSpace = 10001, SpaceName ="302", SpaceType ="Salón" },
                new SpaceDTO {  IdSpace = 10002, SpaceName ="303", SpaceType ="Salón" },
                new SpaceDTO {  IdSpace = 10003, SpaceName ="304", SpaceType ="Laboratorio" },
                new SpaceDTO {  IdSpace = 10004, SpaceName ="401", SpaceType ="Salón" },
                new SpaceDTO {  IdSpace = 10005, SpaceName ="402", SpaceType ="Salón" },
                new SpaceDTO {  IdSpace = 10006, SpaceName ="403", SpaceType ="Salón" },
                new SpaceDTO {  IdSpace = 10007, SpaceName ="501", SpaceType ="Sala" },
                new SpaceDTO {  IdSpace = 10008, SpaceName ="502", SpaceType ="Sala" },
                new SpaceDTO {  IdSpace = 10009, SpaceName ="503", SpaceType ="Sala" },
                new SpaceDTO {  IdSpace = 10010, SpaceName ="504", SpaceType ="Sala" }
            };

            return (SpaceDTOCollection)spaces;
        }
    }
}
