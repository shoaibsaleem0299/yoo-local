import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
import 'package:yoo_local/ui_fuctionality/local_data.dart';

class LocationWidget extends StatefulWidget {
  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  loc.LocationData? currentLocation;
  String _address = "Fetching location...";

  @override
  void initState() {
    super.initState();
    _checkStoredLocation();
  }

  Future<void> _checkStoredLocation() async {
    String? city = await LocalData.getString("city");

    if (city == null) {
      // If no city is stored, get the current location
      await _getLocation();
    } else {
      // If city is stored, display it
      String? country = await LocalData.getString("country");
      setState(() {
        _address = "$city, $country";
      });
    }
  }

  Future<void> _getLocation() async {
    loc.Location location = loc.Location();

    bool serviceEnabled;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // Check if permission is granted
    loc.PermissionStatus permissionGranted;
    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    // Get the current location
    loc.LocationData locationData = await location.getLocation();

    // Get the address from the coordinates
    List<Placemark> placemarks = await placemarkFromCoordinates(
      locationData.latitude!,
      locationData.longitude!,
    );
    Placemark place = placemarks[0];

    // Save city and country in SharedPreferences
    await LocalData.addString("city", place.locality!);
    await LocalData.addString("country", place.country!);

    setState(() {
      currentLocation = locationData;
      _address = "${place.locality}, ${place.country}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          color: Colors.white,
        ),
        SizedBox(width: 4), // Space between icon and text
        Text(
          _address,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
