import 'dart:async';
import 'dart:math';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:pak_lpg/Dashboard/Components/dashboard_drawer.dart';
import 'package:pak_lpg/commons/utils.dart';
import 'package:pak_lpg/constants.dart';
import 'package:pak_lpg/models/get_location_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';


import 'dart:ui' as ui;

import 'package:pak_lpg/models/http_service.dart';

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
}


class LogisticsDetail extends StatefulWidget {

  final String vehicle_no;

  LogisticsDetail({
    this.vehicle_no
  });

  @override
  _LogisticsDetailsState createState() => _LogisticsDetailsState(vehicle_no: vehicle_no);

}

class _LogisticsDetailsState extends State<LogisticsDetail> {

  LatLng currentLocation = LatLng(-2.131910, -79.940287);
  GoogleMapController _mapController;

  LocationModel1 location;
  BitmapDescriptor icon;
  Timer location_timer;
  Duration refreshRate = new Duration(seconds: locationInterval);
  List<String> value;

  final String vehicle_no;
  _LogisticsDetailsState({
    this.vehicle_no
  });
  bool showLoading = false;



  Completer<GoogleMapController> _controller = Completer();

  // Iterable markers = [];
  // Iterable _markers = Iterable.generate(LocationModel1().response.length, (index) {
  //   List <String> value = LocationModel1().response[index].latlong.split(',');
  //   return Marker(
  //       markerId: MarkerId(LocationModel1().response[index].uid),
  //       position: LatLng(
  //           double.parse(value[0]), double.parse(value[1])
  //       ),
  //       infoWindow: InfoWindow(title: LocationModel1().response[index].latlong));
  //
  // });





  Future<String> loadLocation() async {
    location = await HttpService.Locations(context, '1', '31.53079133,74.35122722', showLoading);

      //getIcons();
      locationUpdate();
  }
  locationUpdate() {

    if (location.response.length != null) {
      for(int i = 0; i<=location.response.length; i++) {
        value = location.response[i].latlong.split(',');
        setState(() {
          this.currentLocation =
              LatLng(double.parse(value[0]), double.parse(value[1]) );
          this._mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: this.currentLocation, zoom: 14),


          ));
        });
        print(location.response[i].latlong);
        print('location123');
        print(location.response.length);
        print(value[0]);
        print(value[1]);
      }

    }

  }

  Future<String> loadViewData() async {

    final GlobalKey<State> _keyLoader = new GlobalKey<State>();
    if(showLoading)
      Future.delayed(Duration.zero, () => utils.showLoadingDialog(context, _keyLoader));

    await Future.wait([


      //loadDriverDetails()
    ]);

    if(showLoading) {
      showLoading = false;
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
    }

    return "OK";
  }
  @override
  void initState() {
    setState(() {

     // markers = _markers;
    });
    loadLocation();
    location_timer = new Timer.periodic(
        refreshRate, (Timer t) => loadLocation());    super.initState();

  }



  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }


// icon Marker
  getIcons() async {

    final Uint8List markerIcon = await getBytesFromAsset('assets/images/aah.png', 50);
    //final Marker marker = Marker(icon: BitmapDescriptor.fromBytes(markerIcon));
    // var icon = await BitmapDescriptor.fromAssetImage(
    //     ImageConfiguration(devicePixelRatio: 20.0, size: Size(2, 2)),
    //
    //     "assets/images/aah.png",
    //
    // );
    setState(() {
      this.icon = BitmapDescriptor.fromBytes(markerIcon);
    });
  }

// Marker

  Set<Marker> _createMarker() {
    var marker = Set<Marker>();
    marker.add(Marker(
      markerId: MarkerId("MarkerCurrent"),
      position: currentLocation,
      icon: icon,
      infoWindow: InfoWindow(
        title: "Demo",
        snippet:
        "Lat ${'location.location.Lat'} - Lng ${'location.location.Lng'} ",
      ),
      draggable: true,
      //onDragEnd: onDragEnd,
    ));

    return marker;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBar(context),
      drawer: DashboardDrawer(),
      body: Column(
        children: <Widget>[

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
                      child:
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: currentLocation,
                          zoom: 12.0,
                        ),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        minMaxZoomPreference: MinMaxZoomPreference(12, 18.6),
                        markers: _createMarker(),
                        onMapCreated: _onMapCreated,
                       // markers: Set.from(markers),
                      ),
                      // Map(
                      //   longitude: double.parse(location.location.Lng.toString()),
                      //   latitude: double.parse(location.location.Lat.toString()),
                      //   timestamp: location.location.speed.toString(),
                      //
                      // ),
                    ),
                  ),
                ),
              )
          ),
        ],
      ),

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
        centerTitle: true,
        //foregroundColor: kPrimaryColor1,
        //shadowColor: kPrimaryColor1,
        toolbarHeight: height * .1,
        title: new Text('Home'),
        actions: actions
    );

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