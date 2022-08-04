import 'dart:io';
import 'package:al3la_restaurant/layout/cubit/cubit.dart';
import 'package:al3la_restaurant/layout/layout.dart';
import 'package:al3la_restaurant/shared/component.dart';
import 'package:al3la_restaurant/shared/constant.dart';
import 'package:al3la_restaurant/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
//import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble()async {
    super.reassemble();
    if(Platform.isAndroid ){
      await controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          scannerWidget(context),
          Positioned(
            bottom: 10,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white24,
                ),
                child: const Text("Scan a code",
                  style: TextStyle(color: Colors.white),
          ),
              )),
        ],
      ),
    );
  }
  Widget scannerWidget(BuildContext context) {
    return QRView(
        key: qrKey,
        overlay:QrScannerOverlayShape(
          cutOutSize: MediaQuery.of(context).size.width*0.8,
          borderRadius: 10,
          borderLength: 20,
          borderWidth: 10,
          borderColor: defaultColor,
        ) ,
        onQRViewCreated: (QRViewController controller) {
          setState(() => this.controller = controller);

          controller.scannedDataStream.listen((event) {
            //setState(() => barcode = event);
            token = "${event.code}";
            controller.stopCamera();
            HomeCubit.get(context).getRestaurantInformation(idUser: token!);
            navigateTo(context, const Layout());
          });
        });
  }
}
