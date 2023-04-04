import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class Mapview extends StatefulWidget {
  const Mapview({Key? key}) : super(key: key);

  @override
  State<Mapview> createState() => _MapviewState();
}

class _MapviewState extends State<Mapview> {

  late double lat ;
  late double long ;

  Future getLocation() async {
    Location loc = Location();
    LocationData? locdata = await loc.getLocation();
    lat = locdata!.latitude! ;
    long = locdata!.longitude! ;
    print(lat);
    print(long);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: FutureBuilder(
            future: getLocation(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return
                     Center(
                        child: CircularProgressIndicator(
                          color: Colors.pinkAccent[400],
                        ));
              }
              else {
                return
              GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(lat.toDouble(),long.toDouble()),
                  zoom: 13.5,
                ),
              );
              }
            },
          )
        )
    );
  }
}
