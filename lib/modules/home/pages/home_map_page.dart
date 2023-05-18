import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:organaki_app/core/colors_app.dart';
import 'package:organaki_app/core/extensions.dart';
import 'package:organaki_app/modules/home/components/store_section_component.dart';
import 'package:organaki_app/modules/producer/producer_apresentation_page.dart'; // Only import if required functionality is not exposed by default

class HomeMapPage extends StatefulWidget {
  const HomeMapPage({Key? key}) : super(key: key);

  @override
  State<HomeMapPage> createState() => _HomeMapPageState();
}

class _HomeMapPageState extends State<HomeMapPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    currentLatlong = await getCurrentPosition();

    setState(() {
      _mapOption = MapOptions(center: currentLatlong!, zoom: 14);
      currentLatlong;
    });
  }

  LatLng? currentLatlong;
  final _mapController = MapController();
  late MapOptions _mapOption;

  Future<LatLng?> getCurrentPosition() async {
    LocationPermission response = await Geolocator.requestPermission();
    if (response.name == "whileInUse") {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return LatLng(position.latitude, position.longitude);
    } else {
      // ignore: use_build_context_synchronously
      Flushbar(
              message: 'Você precisa ativar sua localização',
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 6),
              flushbarPosition: FlushbarPosition.TOP)
          .show(context);
    }
    return null;
  }

  void returnCurrentLocation() {
    setState(() {
      _mapController.move(currentLatlong!, 14);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Discover",
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          actions: [
            const Icon(
              Icons.search,
              color: Colors.black,
            ),
            10.sizeW,
            const Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
            15.sizeW,
          ],
        ),
        body: currentLatlong != null // to wait user to get the current value
            ? FlutterMap(
                mapController: _mapController,
                options: _mapOption,
                nonRotatedChildren: [
                  Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          returnCurrentLocation();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 15, right: 15),
                          child: Material(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            elevation: 5,
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Icon(
                                  Icons.my_location,
                                  color: ColorApp.blue3,
                                )),
                          ),
                        ),
                      )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: List.generate(
                          6,
                          (index) {
                            return InkWell(
                                onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            ProducerApresentationPage(
                                          mapOptions: _mapOption,
                                          mapController: _mapController,
                                          currentPosition: currentLatlong!,
                                        ),
                                      ),
                                    ),
                                child: const StoreSectionComponent());
                          },
                        )),
                      ),
                    ),
                  )
                ],
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    // userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  MarkerLayer(
                    markers: [
                      for (int i = 1; i < 20; i++)
                        Marker(
                          point: i % 2 == 0
                              ? LatLng(currentLatlong!.latitude + i * 0.01,
                                  currentLatlong!.longitude + i * 0.001)
                              : LatLng(currentLatlong!.latitude - i * 0.001,
                                  currentLatlong!.longitude - i * 0.01),
                          builder: (context) => Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              color: ColorApp.blue3,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.location_history,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      Marker(
                        point: currentLatlong!,
                        builder: (context) => Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: ColorApp.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
