namespace UAS.Core.DAL.Common.Migrations
{
    using System.Data.Entity.Migrations;

    internal sealed class Configuration : DbMigrationsConfiguration<Model.UASEntities>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
        }

        protected override void Seed(Model.UASEntities context)
        {
            //  This method will be called after migrating to the latest version.

            //  You can use the DbSet<T>.AddOrUpdate() helper extension method 
            //  to avoid creating duplicate seed data. E.g.
            context.Roles.AddOrUpdate(
                new Model.Role { Name = "Administrator", Alias = "Administrador" },
                new Model.Role { Name = "Director", Alias = "Director" },
                new Model.Role { Name = "Teacher", Alias = "Profesor" },
                new Model.Role { Name = "Student", Alias = "Estudiante" });
        }
    }
}
