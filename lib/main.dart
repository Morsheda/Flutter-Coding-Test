// ignore_for_file: prefer_const_constructors, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Set<Marker> _markers = {};
  String _crdnt = "";
  String _name = "";
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('1'),
        position: LatLng(23.7896, 90.3913),
        onTap: () {
          _showModal(context);
        },
      ));
    });
  }

  _showModal(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                  constraints: BoxConstraints(maxHeight: 350),
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              decoration:
                                  InputDecoration(hintText: 'Coordinate'),
                              onChanged: (value) {
                                setState(() {
                                  _crdnt = value;
                                });
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(hintText: 'Name'),
                              onChanged: (value) {
                                setState(() {
                                  _name = value;
                                });
                              },
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  _sendToConsole(_crdnt, _name);
                                },
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blueGrey),
                                ),
                                child: Text(
                                  "Send To Console",
                                  style: TextStyle(color: Colors.white),
                                ))
                          ]))));
        });
  }

  _sendToConsole(String loc, String name) {
    debugPrint('Current Coordinate: $loc');
    debugPrint('Name: $name');
  }
  // static final CameraPosition myPosition =
  //     CameraPosition(target: LatLng(23.7896, 90.3913), zoom: 15.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.deepPurple[200],
      //   elevation: 5.0,
      // ),
      body: GoogleMap(
        initialCameraPosition:
            const CameraPosition(target: LatLng(23.7896, 90.3913), zoom: 15.0),
        onMapCreated: _onMapCreated,
        markers: _markers,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
