import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fresh_mart/constants/constants.dart';
import 'package:fresh_mart/providers/locationProvider.dart';
import 'package:fresh_mart/widgets/reusables.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:provider/provider.dart';

class DeliveryLocationPick extends StatefulWidget {
  @override
  State<DeliveryLocationPick> createState() => _DeliveryLocationPickState();
}

class _DeliveryLocationPickState extends State<DeliveryLocationPick> {
  @override
  void initState() {
    Provider.of<LocationProvider>(context, listen: false).getCurrentPositions();
    // TODO: implement initStateR
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final location = Provider.of<LocationProvider>(context);
    return AlertDialog(
      content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 1,
          child: location.persmissionAllowed
              ? location.isLoading
                  ? LoadingWidget()
                  : OpenStreetMapSearchAndPick(
                      center: LatLong(location.lat, location.long),
                      buttonColor: Colors.green,
                      onPicked: (picked) {
                        print(picked.address);
                        location.lat = picked.latLong.latitude;
                        location.long = picked.latLong.longitude;
                        location.address = picked.address;
                        location.setAddress(picked.address);
                        Navigator.of(context).pop();
                      },
                    )
              : Text('please allow permission')),
    );
  }
}
