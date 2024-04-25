import 'package:flutter/material.dart';

class MapOfCarsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map of Car Locations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Adjust the number of columns as needed
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: 8, // Adjust the number of sectors as needed
          itemBuilder: (context, index) {
            final sector = String.fromCharCode(65 + index); // Convert index to sector name (A, B, C, ...)
            return _buildSectorWidget(sector);
          },
        ),
      ),
    );
  }

  Widget _buildSectorWidget(String sector) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[100],
        border: Border.all(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sector $sector',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: Container(
              color: Colors.grey[100], // Placeholder for the map of car locations
              child: Center(
                child: Text(
                  'Map', // Placeholder text for the map
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
