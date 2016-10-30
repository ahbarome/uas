using Android.App;
using Android.Content;

namespace UAS.Core.Mobile.Helper
{
    public static class UIHelper
    {
        public static ProgressDialog GetProgressDialog(Context context, string message)
        {
            ProgressDialog mProgressDialog = new ProgressDialog(context);
            mProgressDialog.SetMessage(message);
            mProgressDialog.SetCancelable(false);

            return mProgressDialog;
        }
    }
}