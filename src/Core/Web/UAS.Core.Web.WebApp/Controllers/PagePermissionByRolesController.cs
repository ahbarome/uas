using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.Web.WebApp.Controllers
{
    public class PagePermissionByRolesController : FirewallController
    {
        private UASEntities db = new UASEntities();

        // GET: /PagePermissionByRoles/
        public ActionResult Index()
        {
            var pagepermissionbyroles = db.PagePermissionByRoles.Include(p => p.Page).Include(p => p.Role);
            return View(pagepermissionbyroles.ToList());
        }

        // GET: /PagePermissionByRoles/Details/5
        public ActionResult Details(int? idPage, int? idRole)
        {
            if (idPage == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            if (idRole == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            PagePermissionByRole pagePermissionByRole = db.PagePermissionByRoles.Find(idPage, idRole);
            if (pagePermissionByRole == null)
            {
                return HttpNotFound();
            }
            return View(pagePermissionByRole);
        }

        // GET: /PagePermissionByRoles/Create
        public ActionResult Create()
        {
            ViewBag.IdPage = new SelectList(db.Pages, "Id", "Title");
            ViewBag.IdRole = new SelectList(db.Roles, "Id", "Name");
            return View();
        }

        // POST: /PagePermissionByRoles/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include="IdPage,IdRole,IsDefault,IsVisible,CanEdit,CanUpdate,CanSelect,CanDelete")] PagePermissionByRole pagePermissionByRole)
        {
            if (ModelState.IsValid)
            {
                db.PagePermissionByRoles.Add(pagePermissionByRole);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.IdPage = new SelectList(db.Pages, "Id", "Title", pagePermissionByRole.IdPage);
            ViewBag.IdRole = new SelectList(db.Roles, "Id", "Role.Alias", pagePermissionByRole.IdRole);
            return View(pagePermissionByRole);
        }

        // GET: /PagePermissionByRoles/Edit/5
        public ActionResult Edit(int? idPage, int? idRole)
        {
            if (idPage == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            if (idRole == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            PagePermissionByRole pagePermissionByRole = db.PagePermissionByRoles.Find(idPage, idRole);
            if (pagePermissionByRole == null)
            {
                return HttpNotFound();
            }
            ViewBag.IdPage = new SelectList(db.Pages, "Id", "Title", pagePermissionByRole.IdPage);
            ViewBag.IdRole = new SelectList(db.Roles, "Id", "Name", pagePermissionByRole.IdRole);
            return View(pagePermissionByRole);
        }

        // POST: /PagePermissionByRoles/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include="IdPage,IdRole,IsDefault,IsVisible,CanEdit,CanUpdate,CanSelect,CanDelete")] PagePermissionByRole pagePermissionByRole)
        {
            if (ModelState.IsValid)
            {
                db.Entry(pagePermissionByRole).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.IdPage = new SelectList(db.Pages, "Id", "Title", pagePermissionByRole.IdPage);
            ViewBag.IdRole = new SelectList(db.Roles, "Id", "Name", pagePermissionByRole.IdRole);
            return View(pagePermissionByRole);
        }

        // GET: /PagePermissionByRoles/Delete/5
        public ActionResult Delete(int? idPage, int? idRole)
        {
            if (idPage == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            if (idRole == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            PagePermissionByRole pagePermissionByRole = db.PagePermissionByRoles.Find(idPage, idRole);
            if (pagePermissionByRole == null)
            {
                return HttpNotFound();
            }
            return View(pagePermissionByRole);
        }

        // POST: /PagePermissionByRoles/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int? idPage, int? idRole)
        {
            PagePermissionByRole pagePermissionByRole = db.PagePermissionByRoles.Find(idPage, idRole);
            db.PagePermissionByRoles.Remove(pagePermissionByRole);
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
