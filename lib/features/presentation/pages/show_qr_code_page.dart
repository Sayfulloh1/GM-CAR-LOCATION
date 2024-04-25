import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'find_car_location_page.dart';
import 'map_of_cars.dart';
import 'dart:math' show Random;

class ShowQRCodePage extends StatefulWidget {
  const ShowQRCodePage({super.key});

  @override
  _ShowQRCodePageState createState() => _ShowQRCodePageState();
}

class _ShowQRCodePageState extends State<ShowQRCodePage> {
  TextEditingController idController = TextEditingController();
  int carLocationIndex = Random().nextInt(60);

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }
  void goHomePage(String? qrCode){

    Navigator.pop(context,qrCode);
  }

  @override
  void initState() {

    super.initState();
  }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR CODE'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            Expanded(
              flex: 3,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: (result != null)
                    ? Text(
                    '${result!.code}'.substring(39))
                    : Text('Scan a code'),
              ),
            ),
            TextButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FindCarLocationPage(carId: carLocationIndex),
                ),
              );
            }, child: Text('Find car'),),

          ],
        ),
      ),
    );
  }
}
