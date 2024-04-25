import 'package:flutter/material.dart';
import 'dart:math' show Random;

class FindCarLocationPage extends StatefulWidget {
  const FindCarLocationPage({Key? key, required this.carId}) : super(key: key);

  final int carId;

  @override
  State<FindCarLocationPage> createState() => _FindCarLocationPageState();
}

class _FindCarLocationPageState extends State<FindCarLocationPage> {
  late int carIndex;

  List<String> owner = [
    'Car holder: Iskandarov Baxtiyor',
    'Car holder: Abduvohidov Zoirjon',
    'Car holder: Ergashiv Jamoldin',
    'Car holder: Davronov Elbek',
  ];

  List<String> model = [
    'Car model: Black Gentra',
    'Car model: White Tahoe',
    'Car model: Grey Cobalt',
    'Car model: Black Malibu Turbo',
  ];

  @override
  void initState() {
    super.initState();
    carIndex = widget.carId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car address'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Sector A',
                style: TextStyle(fontSize: 20),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .53,
                color: Colors.blue[100],
                child: GridView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: 80,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      color:
                          index == carIndex ? Colors.orange : Colors.grey[100],
                      margin: EdgeInsets.all(2.0),
                    );
                  },
                ),
              ),
              SizedBox(height: 40),
              Column(
                children: [
                  Row(
                    children: [
                      Text(owner[Random().nextInt(4)]),
                    ],
                  ),
                  Row(
                    children: [
                      Text(model[Random().nextInt(4)]),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Icon(Icons.arrow_upward, color: Colors.green, size: 50),
                      SizedBox(height: 10),
                      Text(
                        'Entrance',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
