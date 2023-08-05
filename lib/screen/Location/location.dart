import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

import '../../customFunction/LocationGraph.dart';
import '../../data/LocationNode.dart';

class LocationScreen extends StatefulWidget{
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = "AIzaSyDFl537nYb0R7zQNcXk9Xrmniy00aM7sK4";

  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  late LatLng startLocation;
  late LatLng endLocation;

  double distance = 0.0;

  late Map<LocationNode, Map<LocationNode, double>> adjacencyMap;

  late List<LocationNode> locations;
  late LocationGraph graph;
  late LocationNode sourceNode;
  List<LocationNode> routeList = [];



  // Apply Dijkstra's algorithm to find the shortest paths from the source node to all other locations



  @override
  void initState() {

    locations = [
      LocationNode('Bin 0001', 6.865619, 79.899823),
      LocationNode('Bin 0002', 6.841301, 79.894515),
      LocationNode('Bin 0003', 6.845209, 79.947739),
      LocationNode('Bin 0004', 6.822693, 79.948239),
      LocationNode('Bin 0005', 6.883999, 79.908503),
      LocationNode('Bin 0006', 6.903295, 79.967547),
      LocationNode('Bin 0007', 6.874508, 79.999696),
    ];

    adjacencyMap = {};

    double degToRad(double deg) {
      return deg * (pi / 180.0);
    }

    double calculateDistance(LocationNode location1, LocationNode location2) {
      const double earthRadius = 6371.0; // Earth's radius in km

      double lat1Radians = degToRad(location1.latitude);
      double lon1Radians = degToRad(location1.longitude);
      double lat2Radians = degToRad(location2.latitude);
      double lon2Radians = degToRad(location2.longitude);

      double dLat = lat2Radians - lat1Radians;
      double dLon = lon2Radians - lon1Radians;

      double a = pow(sin(dLat / 2), 2) +
          cos(lat1Radians) * cos(lat2Radians) * pow(sin(dLon / 2), 2);
      double c = 2 * atan2(sqrt(a), sqrt(1 - a));

      double distance = earthRadius * c;
      return distance;
    }



    for (int i = 0; i < locations.length; i++) {
      adjacencyMap[locations[i]] = {};
      for (int j = 0; j < locations.length; j++) {
        if (i != j) {
          double distance = calculateDistance(locations[i], locations[j]);
          adjacencyMap[locations[i]]?[locations[j]] = distance;
        }
      }
    }



    LocationNode start = LocationNode('Start', locations[0].latitude, locations[0].longitude);
    LocationNode end = LocationNode('End', locations[1].latitude, locations[1].longitude);

    startLocation = LatLng(start.latitude, start.longitude);
    endLocation = LatLng(end.latitude, end.longitude);
    sourceNode = start;

    graph = LocationGraph(nodes: locations, adjacencyMap: adjacencyMap);
    Map<LocationNode, double> shortestDistances = {};
    List<LocationNode> travelList = [];
    LocationNode currentSource = locations[0];
    LocationNode currentDestination = locations[6];
    List<String> travelListNames = [];
    travelListNames.add(currentSource.name);


    for(var i = 0; i < locations.length; i++){
      shortestDistances = graph.dijkstraShortestPath(currentSource);
      // get the closest location to the current location
      double minDistance = double.infinity;
      LocationNode? minDistanceNode;
      for (var node in locations) {
        if (shortestDistances[node]! < minDistance && node.name != currentSource.name && !travelListNames.contains(node.name)) {
          minDistance = shortestDistances[node]!;
          minDistanceNode = node;
        }
      }
      if(minDistanceNode == null){
        break;
      }
      travelListNames.add(minDistanceNode.name);
      getDirections(currentSource, minDistanceNode);
      currentSource = minDistanceNode;
    }

    // print travel list
    for(var i = 0; i < travelListNames.length; i++){
      // Add to routeList
      for(var j = 0; j < locations.length; j++){
        if(travelListNames[i] == locations[j].name){
          routeList.add(locations[j]);
        }
      }
    }



    //set markers for all locations
    for(var i = 0; i < locations.length; i++){
      markers.add(Marker(
          markerId: MarkerId(locations[i].name),
          position: LatLng(locations[i].latitude, locations[i].longitude),
          infoWindow: InfoWindow(
              title: locations[i].name,
              snippet: locations[i].latitude.toString() + ", " + locations[i].longitude.toString()
          )
      ));
    }


    super.initState();
  }

  getDirections(LocationNode startLocation,LocationNode endLocation) async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }

    //polulineCoordinates is the List of longitute and latidtude.
    double totalDistance = 0;
    for(var i = 0; i < polylineCoordinates.length-1; i++){
      totalDistance += calculateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i+1].latitude,
          polylineCoordinates[i+1].longitude);
    }
    double totDis = distance + totalDistance;
    // Make the distance 2 decimal places
    totDis = double.parse(totDis.toStringAsFixed(2));

    setState(() {
      distance = totDis;
    });

    //add to the list of poly line coordinates
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    // random id to identify the polylines
    // Array Of Colors
    PolylineId id = PolylineId(Random().nextInt(100).toString());
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 +
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("Drive Path"),
          titleSpacing: 20.0,
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Stack(
            children:[
              GoogleMap(
                zoomGesturesEnabled: true, //enable Zoom in, out on map
                initialCameraPosition: CameraPosition( //innital position in map
                  target: startLocation, //initial position
                  zoom: 14.0, //initial zoom level
                ),
                markers: markers, //markers to show on map
                polylines: Set<Polyline>.of(polylines.values), //polylines
                mapType: MapType.normal, //map type
                onMapCreated: (controller) { //method called when map is created
                  setState(() {
                    mapController = controller;
                  });
                },
              ),

        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  height: 50,
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      "Total Distance: $distance km",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: routeList.length,
                    itemBuilder: (context, index) {
                      LocationNode location = routeList[index];
                      return ListTile(
                        title: Text(location.name),
                        subtitle: Text(
                          "${location.latitude}, ${location.longitude}",
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
        )
            ]
        )
    );
  }
}