using Android.App;
using Android.Widget;
using Android.OS;
using ZXing.Mobile;
using System.Collections.Generic;
using Android.Media;
using UAS.Core.Mobile.UI.Adapters;
using UAS.Core.DTO.Entities;
using UAS.Core.Mobile.BLL;
using System.Threading.Tasks;
using UAS.Core.Mobile.Helper;
using UAS.Core.DTO.Parsers;

namespace UAS.Core.Mobile.UI
{
    [Activity(Label = "UAS QR Reader", MainLauncher = true, Icon = "@drawable/icon")]
    public class MainActivity : Activity
    {
        #region Attributes

        Button btnOneStepScan;
        Button btnContinuosScan;
        MobileBarcodeScanner scanner;
        MediaPlayer player;

        #endregion

        #region Override

        protected async override void OnCreate(Bundle bundle)
        {
            base.OnCreate(bundle);

            MobileBarcodeScanner.Initialize(Application);

            SetContentView(Resource.Layout.Main);

            scanner = new MobileBarcodeScanner();

            player = MediaPlayer.Create(this, Resource.Raw.beep);

            btnOneStepScan = this.FindViewById<Button>(Resource.Id.btnOneStepScan);
            btnContinuosScan = FindViewById<Button>(Resource.Id.btnContinuosScan);

            btnOneStepScan.Click += async delegate
            {
                if (ValidateSpace())
                {
                    var options = new MobileBarcodeScanningOptions();

                    var formats = new List<ZXing.BarcodeFormat>()
                    { 
                        ZXing.BarcodeFormat.QR_CODE,
                        ZXing.BarcodeFormat.EAN_8,
                        ZXing.BarcodeFormat.EAN_13
                    };

                    options.PossibleFormats = new List<ZXing.BarcodeFormat>(formats);

                    scanner.UseCustomOverlay = false;
                    scanner.TopText = "Acerque su cámara mientras reconocemos el código de barra";
                    scanner.BottomText = "Por favor espere mientras se realiza el escaneo automático...";

                    var result = await scanner.Scan(options);

                    SendResultToService(result);
                }
            };

            btnContinuosScan.Click += delegate
            {
                if (ValidateSpace())
                {
                    scanner.UseCustomOverlay = false;
                    scanner.TopText = "Acerque su cámara mientras reconocemos el código de barra";
                    scanner.BottomText = "Por favor espere mientras se realiza el escaneo automático...";

                    var options = new MobileBarcodeScanningOptions();
                    options.DelayBetweenContinuousScans = 3000;

                    scanner.ScanContinuously(options, SendResultToService);
                }
            };

            await PopulateSpinner();
        }

        #endregion

        #region Methods

        private async void SendResultToService(ZXing.Result result)
        {
            string message = string.Empty;

            if (result != null && !string.IsNullOrEmpty(result.Text))
            {
                player.Start();

                try
                {
                    var spnrSpace = FindViewById<Spinner>(Resource.Id.spnSpaceType);
                    var qrCodeDTO = DTOParser.JSONToQRCodeDTO(result.Text);

                    await CoreFacade.GenerateMovement(new MovementDTO() { UserDocumentNumber = qrCodeDTO.DocumentNumber, Space = (int)spnrSpace.SelectedItemId });

                    message = "Enviando movimiento al servidor...";
                }
                catch
                {
                    message = "Código QR inválido...";
                }
            }
            else
            {
                message = "Escaneo Cancelado...";
            }

  
            this.RunOnUiThread(() => Toast.MakeText(this, message, ToastLength.Short).Show());
        }

        private async Task PopulateSpinner()
        {
            var progress = UIHelper.GetProgressDialog(this, "Cargando los espacios disponibles, por favor espere...");
            progress.Show();

            var spnrSpace = FindViewById<Spinner>(Resource.Id.spnSpaceType);
            var spaces = await CoreFacade.GetAvailableSpaces();
            var spaceAdapter = new SpinnerAdapter(this, global::Android.Resource.Layout.SimpleSpinnerItem, spaces);

            spaceAdapter.SetDropDownViewResource(global::Android.Resource.Layout.SimpleSpinnerItem);
            spnrSpace.Adapter = spaceAdapter;

            progress.Hide();
        }

        private bool ValidateSpace()
        {
            var spnrSpace = FindViewById<Spinner>(Resource.Id.spnSpaceType);
            var adapter = (SpinnerAdapter)spnrSpace.Adapter;

            if (spnrSpace.SelectedItem != null)
            {
                return true;
            }

            AlertDialog alert = new AlertDialog.Builder(this)
                .SetTitle("Espacio Sin Seleccionar")
                .SetMessage("Por favor seleccione un espacio disponible antes de escanear el código QR.")
                .SetPositiveButton("Aceptar", delegate { })
                .Create();

            alert.Show();

            return false;
        }

        #endregion
    }
}

