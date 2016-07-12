using System;
using System.Collections.Generic;
using UAS.Core.DAL.Common.Model;

namespace UAS.Core.Session.Builders
{
    internal class PagesBuilder
    {
        /// <summary>
        /// 
        /// </summary>
        private ICollection<PagePermissionByRole> _pagePermissionByRoles;

        /// <summary>
        /// 
        /// </summary>
        /// <param name="pagePermissionByRoles"></param>
        public PagesBuilder(ICollection<PagePermissionByRole> pagePermissionByRoles)
        {
            this._pagePermissionByRoles = pagePermissionByRoles;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        internal List<Entities.Page> Build()
        {
            var pages = new List<Entities.Page>();

            foreach (var currentPage in _pagePermissionByRoles)
            {
                var page = new Entities.Page
                {
                    Title = currentPage.Page.Title,
                    ParentId = currentPage.Page.ParentId,
                    MenuItem = currentPage.Page.MenuItem,
                    IsDefault = currentPage.IsDefault,
                    IsVisible = currentPage.IsVisible,
                    IdPage = currentPage.IdPage,
                    IconClass = currentPage.Page.Icon
                };
                pages.Add(page);
            }

            return pages;
        }
    }
}