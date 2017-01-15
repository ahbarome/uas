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
        static string TOP_TEXT = "Por favor acerque su código a la cámara";
        static string BOTTOM_TEXT = "La lectura durará unos segundos, por favor espere...";
        static string STRING_TO_REPLACE_IN_QR_CODE_FROM = "&#34;";
        static string STRING_TO_REPLACE_IN_QR_CODE_TO = "\"";
        static string DEFAULT_ERROR_MESSAGE = "Código QR inválido...";
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
                    scanner.TopText = TOP_TEXT;
                    scanner.BottomText = BOTTOM_TEXT;

                    var result = await scanner.Scan(options);

                    SendResultToService(result);
                }
            };

            btnContinuosScan.Click += delegate
            {
                if (ValidateSpace())
                {
                    scanner.UseCustomOverlay = false;
                    scanner.TopText = TOP_TEXT;
                    scanner.BottomText = BOTTOM_TEXT;

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

                    var qrData =
                        result.Text.Replace(
                            STRING_TO_REPLACE_IN_QR_CODE_FROM, STRING_TO_REPLACE_IN_QR_CODE_TO);
                    var qrCodeDTO = DTOParser.JSONToQRCodeDTO(qrData);

                    await CoreFacade.GenerateMovement(
                        new MovementDTO()
                        {
                            UserDocumentNumber = qrCodeDTO.DocumentNumber,
                            Space = (int)spnrSpace.SelectedItemId
                        });

                    message =
                        string.Format(
                            "Enviando registro de movimiento de [{0}] con número de documento"
                            + " [{1}], al servidor...",
                            qrCodeDTO.Name + " " + qrCodeDTO.LastName,
                            qrCodeDTO.DocumentNumber);
                }
                catch (Java.Lang.Exception javaException)
                {
                    message = DEFAULT_ERROR_MESSAGE;
                }
#pragma warning disable CS0168 // La variable está declarada pero nunca se usa
                catch (System.Exception exception)
#pragma warning restore CS0168 // La variable está declarada pero nunca se usa
                {
                    message = DEFAULT_ERROR_MESSAGE;
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

