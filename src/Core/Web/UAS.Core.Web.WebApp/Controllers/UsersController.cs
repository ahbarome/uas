using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.Web.WebApp.Controllers
{
    public class UsersController : FirewallController
    {
        private UASEntities db = new UASEntities();

        // GET: /Users/
        public ActionResult Index()
        {
            var users = db.Users.Include(u => u.Role);
            return View(users.ToList());
        }

        // GET: /Users/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // GET: /Users/Create
        public ActionResult Create()
        {
            ViewBag.IdRole = new SelectList(db.Roles, "Id", "Name");
            return View();
        }

        // POST: /Users/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="Id,Username,Password,IdRole,Name,LastName,Email,TelephoneNumber,IsActive,RegisterDate,CreatedBy,LastModiticationDate,ModifiedBy,DocumentNumber,ImageRelativePath")] User user)
        {
            if (ModelState.IsValid)
            {
                db.Users.Add(user);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.IdRole = new SelectList(db.Roles, "Id", "Name", user.IdRole);
            return View(user);
        }

        // GET: /Users/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            ViewBag.IdRole = new SelectList(db.Roles, "Id", "Name", user.IdRole);
            return View(user);
        }

        // POST: /Users/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="Id,Username,Password,IdRole,Name,LastName,Email,TelephoneNumber,IsActive,RegisterDate,CreatedBy,LastModiticationDate,ModifiedBy,DocumentNumber,ImageRelativePath")] User user)
        {
            if (ModelState.IsValid)
            {
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IdRole = new SelectList(db.Roles, "Id", "Name", user.IdRole);
            return View(user);
        }

        // GET: /Users/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            User user = db.Users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View(user);
        }

        // POST: /Users/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            User user = db.Users.Find(id);
            db.Users.Remove(user);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
