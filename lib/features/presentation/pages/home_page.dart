import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gm_car_location_detector/features/presentation/pages/show_qr_code_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'find_car_location_page.dart';
import 'firebase_data_screen.dart';
import 'map_of_cars.dart';
import 'dart:math' show Random;

class CarLocationScreen extends StatefulWidget {
  const CarLocationScreen({super.key});

  @override
  _CarLocationScreenState createState() => _CarLocationScreenState();
}

class _CarLocationScreenState extends State<CarLocationScreen> {
  TextEditingController idController = TextEditingController();
  int carLocationIndex = Random().nextInt(70);

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  String inputString = 'Car id';

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var qrCode = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Car Location'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .63,
                  child: TextFormField(
                    // initialValue: inputString,

                    controller: idController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ShowQRCodePage())).then(
                            (value) {
                              if (value != null) {
                                setState(() {
                                  inputString = value;
                                });
                              }
                            },
                          );
                        },
                        icon: const Icon(CupertinoIcons.qrcode),
                      ),
                      hintText: 'Enter car id',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(20, MediaQuery.of(context).size.height * .08),
                    backgroundColor: Colors.teal,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FindCarLocationPage(carId: carLocationIndex),
                      ),
                    );
                  },
                  child: const Text(
                    'Find',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
            SizedBox(
              width: 200,
              height: 200,
              child: Card(
                elevation: 10,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'See full map',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.teal,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapOfCarsPage(),
                          ),
                        );
                      },
                      child: Text(
                        'GO -> 🗺️️',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ],
                )),
              ),
            ),
            const SizedBox(height: 100),
            SizedBox(
              width: 200,
              height: 200,
              child: Card(
                elevation: 10,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Locations of esp32',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.teal,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FirebaseDataScreen()));
                      },
                      child: Text('Get points'),
                    ),
                  ],
                )),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
