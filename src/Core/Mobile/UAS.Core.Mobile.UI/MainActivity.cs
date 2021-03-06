﻿using Android.App;
using Android.Widget;
using Android.OS;
using ZXing.Mobile;
using System.Collections.Generic;
using Android.Media;
using UAS.Core.Mobile.UI.Adapters;
using UAS.Core.DTO.Entities;
using UAS.Core.Mobile.BLL;

namespace UAS.Core.Mobile.UI
{
    [Activity(Label = "UAS.Core.Mobile", MainLauncher = true, Icon = "@drawable/icon")]
    public class MainActivity : Activity
    {
        #region Attributes

        Button btnOneStepScan;
        Button btnContinuosScan;
        MobileBarcodeScanner scanner;
        MediaPlayer player;

        #endregion

        #region Override

        protected override void OnCreate(Bundle bundle)
        {
            base.OnCreate(bundle);

            MobileBarcodeScanner.Initialize(Application);

            SetContentView(Resource.Layout.Main);

            scanner = new MobileBarcodeScanner();

            player = MediaPlayer.Create(this, Resource.Raw.beep);

            btnOneStepScan = this.FindViewById<Button>(Resource.Id.btnOneStepScan);

            btnOneStepScan.Click += async delegate
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

                player.Start();

                SendResultToService(result);
            };

            btnContinuosScan = FindViewById<Button>(Resource.Id.btnContinuosScan);
            btnContinuosScan.Click += delegate
            {
                scanner.UseCustomOverlay = false;
                scanner.TopText = "Acerque su cámara mientras reconocemos el código de barra";
                scanner.BottomText = "Por favor espere mientras se realiza el escaneo automático...";

                var options = new MobileBarcodeScanningOptions();
                options.DelayBetweenContinuousScans = 3000;

                scanner.ScanContinuously(options, SendResultToService);

                player.Start();
            };

            PopulateSpinner();
        }

        #endregion

        #region Methods

        private void SendResultToService(ZXing.Result result)
        {
            string message = string.Empty;

            if (result != null && !string.IsNullOrEmpty(result.Text))
            {
                // @TODO: Connect to the Gateway Service and send the SpaceId and 
                // document number.
                // Example of the QR structure: 
                // {
                //      "DocumentNumber": 1144428800,
                //      "Name": "Byron Vicente",
                //      "LastName": "Escobar Estrada",
                //      "Program": 3711,
                //      "University": "Universidad Libre Seccional Cali",
                // }
                // The SpaceId is the value from the selected combo box
                message = string.Format("Enviando a Servidor: {0}", result.Text);
            }
            else
            {
                message = "Escaneo Cancelado...";
            }

            this.RunOnUiThread(() => Toast.MakeText(this, message, ToastLength.Short).Show());
        }

        private void PopulateSpinner()
        {
            var spnrSpace = FindViewById<Spinner>(Resource.Id.spnSpaceType);
            var spaces = CoreFacade.GetAvailableSpaces().Result; 
            var spaceAdapter =
                new SpinnerAdapter(this, global::Android.Resource.Layout.SimpleSpinnerItem, spaces);

            spaceAdapter.SetDropDownViewResource(global::Android.Resource.Layout.SimpleSpinnerItem);
            spnrSpace.Adapter = spaceAdapter;
        }
       
        
        #endregion
    }
}

