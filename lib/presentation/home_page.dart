import 'package:android_intent_plus/android_intent.dart';
import 'package:app_rute/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String location = 'Belum Mendapatkan Lat dan long, Silahkan tekan button';
  String address = 'Mencari lokasi...';
  TextEditingController textLokasi = TextEditingController();
  //getLongLAT
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //location service not enabled, don't continue
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location service Not Enabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    //permission denied forever
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permission denied forever, we cannot access',
      );
    }
    //continue accessing the position of device
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  // //getAddress
  Future<void> getAddressFromLongLat(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    setState(() {
      address =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Lokasi anda',
                          style: blackTextStyle.copyWith(
                              fontSize: 22, fontWeight: bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(location,
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: bold,
                            )),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Address',
                          style: blackTextStyle.copyWith(
                            fontSize: 22,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(address),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () async {
                            Position position = await _getGeoLocationPosition();
                            setState(() {
                              location =
                                  '${position.latitude}, ${position.longitude}';
                            });
                            getAddressFromLongLat(position);
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Get Koordinat",
                                  style: bgTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: semiBold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Tujuan Anda',
                              style: blackTextStyle.copyWith(
                                  fontSize: 22, fontWeight: bold))),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: TextFormField(
                          controller: textLokasi,
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Lokasi Tujuan Anda',
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 10.0, 20.0, 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              // Mengatur border ketika TextFormField difokuskan
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 12, 222, 237),
                              ), // Mengatur warna border menjadi hijau saat difokuskan
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            final intent = AndroidIntent(
                              action: 'action_view',
                              data: Uri.encodeFull(
                                  'google.navigation:q=${textLokasi.text}&avoid=tf'),
                              package: 'com.google.android.apps.maps',
                            );
                            intent.launch();
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Find Address",
                                  style: bgTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: semiBold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
