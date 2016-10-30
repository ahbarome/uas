using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UAS.Core.DTO.Entities;
using Android.App;
using Android.Content;
using Android.OS;
using Android.Runtime;
using Android.Views;
using Android.Widget;

namespace UAS.Core.Mobile.UI.Adapters
{
    public class SpinnerAdapter : ArrayAdapter<SpaceDTO>
    {
        #region Attributes

        protected SpaceDTOCollection mItems { get; set; }
        private readonly Activity mContext;

        #endregion

        #region Constructor

        public SpinnerAdapter(Activity context, int resource, SpaceDTOCollection items)
            : base(context, resource, items)
        {
            this.mItems = items;
            this.mContext = context;
        }

        #endregion

        #region Public Methods

        public override long GetItemId(int position)
        {
            return (long)this.mItems.ElementAt(position).IdSpace;
        }

        public SpaceDTO GetItem(int position)
        {
            return this.mItems[position];
        }

        #endregion

        #region Override Methods

        public override View GetDropDownView(int position, View convertView, ViewGroup parent)
        {
            return this.GetCustomView(position, convertView, parent);
        }

        public override View GetView(int position, View convertView, ViewGroup parent)
        {
            return this.GetCustomView(position, convertView, parent);
        }

        #endregion

        #region Private Methods

        private View GetCustomView(int position, View convertView, ViewGroup parent)
        {
            var vwSpinnerItem = (
                           convertView ??
                           mContext.LayoutInflater.Inflate(Resource.Layout.Spinner, parent, false)
                       )
                        as RelativeLayout;

            var txtSpinnerItem = vwSpinnerItem.FindViewById<TextView>(Resource.Id.txtItemValue);
            txtSpinnerItem.Text = string.Concat(this.mItems.ElementAt(position).SpaceType, " ", this.mItems.ElementAt(position).SpaceName);

            return vwSpinnerItem;
        }

        #endregion
    }
}