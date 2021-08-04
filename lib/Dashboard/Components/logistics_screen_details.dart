
import 'dart:async';
import 'dart:math';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pak_lpg/commons/constants.dart';
import 'package:pak_lpg/commons/http_requests.dart';
import 'package:pak_lpg/commons/utils.dart';
import 'package:pak_lpg/models/get_location_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LogisticsDetail extends StatefulWidget {

  final String vehicle_no;

  LogisticsDetail({
    this.vehicle_no
});

  @override
  _LogisticsDetailsState createState() => _LogisticsDetailsState(vehicle_no: vehicle_no);

}

class _LogisticsDetailsState extends State<LogisticsDetail> {

  final String vehicle_no;
  _LogisticsDetailsState({
    this.vehicle_no
  });
  bool showLoading = false;

  DriverLocation location;

  Future<String> loadLocation() async {
    location = await HTTPRequest.GetDriverLocation(vehicle_no, context, showLoading);
  }

  Future<String> loadViewData() async {

    final GlobalKey<State> _keyLoader = new GlobalKey<State>();
    if(showLoading)
      Future.delayed(Duration.zero, () => utils.showLoadingDialog(context, _keyLoader));

    await Future.wait([
      loadLocation(),
    //loadDriverDetails()
    ]);

    if(location == null || location.code.compareTo("100")==0) {
      location = DriverLocation(location: Location(latitude: "0", longitude: "0", trip_id: "0", timestamp: "-", vehicle_no: "-"),
      vehicle: Vehicle(assigned_datetime: "-",
          delivery_datetime: "-",
          end_trip: "-",
          load_qty_mt: "-",
          offload_qty_mt: "-",
          reporting_time: "-",
          start_trip: "-"));
      Future.delayed(Duration.zero, () => utils.dataSuccessfullyLoaded(context, "Server Response","Location not found.", "OK"));
    }

    if(showLoading) {
      showLoading = false;
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
    }

    return "OK";
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<String>(
        future: loadViewData(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {

            TextStyle tableTextStyleLeft = new TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 14.0);
            TextStyle tableTextStyleRight = new TextStyle(color: Colors.lightGreen, fontSize: 16.0, fontWeight: FontWeight.w500);
            bool locationExist = location.location.longitude == 0 ? false : true;
            return Scaffold(
              appBar: buildAppBar(context),
              body: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width-20,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0), color: kPrimaryColor
                              ),
                              height: 40,
                              child: Text("Driver Trip Details", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
                            )
                          ],
                        ),
                        SizedBox(height: 20,),
                        Table(
                          border: TableBorder.lerp(TableBorder.symmetric(inside: BorderSide(width: 2, color: Colors.grey)), TableBorder(bottom: BorderSide(width: 4, color: Colors.green)), 0.5),
                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(
                                children: [
                                  Text("Reporting Time", textAlign: TextAlign.center, style: tableTextStyleLeft,),
                                  Text(location.vehicle.reporting_time, textAlign: TextAlign.center, style: tableTextStyleRight,)
                                ]
                            ),
                            TableRow(
                                children: [
                                  Text("Trip Start Time", textAlign: TextAlign.center, style: tableTextStyleLeft,),
                                  Text(location.vehicle.start_trip, textAlign: TextAlign.center, style: tableTextStyleRight,)
                                ]
                            ),
                            TableRow(
                                children: [
                                  Text("Assigned Time", textAlign: TextAlign.center, style: tableTextStyleLeft,),
                                  Text(location.vehicle.assigned_datetime, textAlign: TextAlign.center, style: tableTextStyleRight,)
                                ]
                            ),
                            TableRow(
                                children: [
                                  Text("Location Reported On", textAlign: TextAlign.center, style: tableTextStyleLeft,),
                                  Text(location.location.timestamp, textAlign: TextAlign.center, style: tableTextStyleRight,)
                                ]
                            ),
                            TableRow(
                                children: [
                                  Text("Vehicle #", textAlign: TextAlign.center, style: tableTextStyleLeft,),
                                  Text(location.location.vehicle_no, textAlign: TextAlign.center, style: tableTextStyleRight,)
                                ]
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width-20,
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0), color: kPrimaryColor
                              ),
                              height: 25,
                              child: Text("Driver Location", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  locationExist ?
                  Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            heightFactor: 0.3,
                            widthFactor: 2.5,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: Colors.grey
                              ),
                              //child: MapSample()
                              child: Map(
                                longitude: double.parse(location.location.longitude),
                                latitude: double.parse(location.location.latitude),
                                timestamp: location.location.timestamp,
                              ),
                            ),
                          ),
                        ),
                      )
                  ) : Text("Location Not Found!", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),)
                ],
              ),
              
            );
          }
          else {
            return utils.circularIndicatorInView();
          }
        }
    );
  }

  AppBar buildAppBar(BuildContext context) {

    List<Widget> actions = [];
    actions.add(IconButton(
        icon: Icon(Icons.refresh),
        onPressed: () {

          setState(() {
            showLoading = true;
          });
        }));

    double height = MediaQuery.of(context).size.height;
    return new AppBar(
        backgroundColor: kPrimaryColor,
        //foregroundColor: kPrimaryColor1,
        shadowColor: kPrimaryColor1,
        toolbarHeight: height * .1,
        title: new Text('Logistics Driver Location'),
        actions: actions);

  }

  Future<void> _askedToLead() async {
    switch (await showDialog<ReloadChoice>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Reload Options'),
            shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            children: <Widget>[
              Divider(thickness: 1,),
              SimpleDialogOption(
                  onPressed: () { Navigator.pop(context, ReloadChoice.RELOAD_FROM_SERVER); },
                  child: new Row(
                    children: <Widget>[
                      Icon(Icons.storage),
                      SizedBox(width: MediaQuery.of(context).size.width * .02,),
                      const Text('Reload list from server!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    ],
                  )
              ),
            ],
          );
        }
    )) {
      case ReloadChoice.RELOAD_FROM_SERVER:
      // ...
        setState(() {
          showLoading = true;
        });
        break;
    }
  }
}

class Map extends StatefulWidget {
  
  final double latitude;
  final double longitude;
  final String timestamp;
  
  Map({@required this.longitude, this.latitude, this.timestamp});
  
  @override
  State<Map> createState() => MapState(longitude: longitude, latitude: latitude, timestamp: timestamp);
}

class MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();

  final double latitude;
  final double longitude;
  final String timestamp;

  MapState({@required this.longitude, this.latitude, this.timestamp});

  Set<Marker> _markers = HashSet<Marker>();
  int _markerIdCounter = 1;
  bool _isMarker = false;
  BitmapDescriptor _markerIcon;
  GoogleMapController _googleMapController;

  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/logo.png');
  }

  // Set Markers to the map
  void _setMarkers(LatLng point) {
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    setState(() {
      print(
          'timestamp: ${timestamp} Latitude: ${point.latitude}  Longitude: ${point.longitude}');
      _markers.add(
        Marker(
          markerId: MarkerId(markerIdVal),
          position: point,
        ),
      );
    });
  }

  // Start the map with this marker setted up
  Future<void> _onMapCreated(GoogleMapController controller) async {
    _googleMapController = controller;

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('0'),
          position: LatLng(latitude, longitude),
          infoWindow:
          InfoWindow(title: 'Driver Current Location', snippet: 'timestamp: ${timestamp}'),
          //icon: _markerIcon,
        ),
      );
    });
  }
    @override
  Widget build(BuildContext context) {

      double width = MediaQuery.of(context).size.width;
      final CameraPosition _kGooglePlex = CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 14.4746,
      );

      return new Scaffold(

          body: Container(
            //padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
            ),
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: _onMapCreated,
              markers: _markers,
            ),
          )
      );
    }

}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}