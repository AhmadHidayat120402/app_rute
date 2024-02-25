import 'package:app_rute/data/datasource/local_datasources.dart';
import 'package:app_rute/presentation/authenticate_page.dart';
import 'package:app_rute/presentation/bottom_navigasi.dart';
import 'package:app_rute/shared/theme.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  void initState() {
    checkAuth();
    super.initState();
  }

  void checkAuth() async {
    final auth = await LocalDataSource().getToken();
    if (auth.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const BottomNavigasi();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: ListView(padding: const EdgeInsets.only(top: 80), children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Image.asset('assets/images/logo.png'),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Welcome to\nApps Rute",
                  style: whiteTextStyle.copyWith(
                    fontWeight: bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const AuthenticationPage();
                    }));
                  },
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromARGB(255, 12, 222, 237),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "LETS GET\nSTARTED",
                          style: whiteTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: semiBold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
