import 'package:app_rute/bloc/get_profile/get_profile_bloc.dart';
import 'package:app_rute/bloc/login/login_bloc.dart';
import 'package:app_rute/bloc/register/register_bloc.dart';
import 'package:app_rute/bloc/update_profile/update_profile_bloc.dart';
import 'package:app_rute/data/datasource/get_profile_datasources.dart';
import 'package:app_rute/data/datasource/local_datasources.dart';
import 'package:app_rute/data/datasource/login_datasources.dart';
import 'package:app_rute/data/datasource/register_datasources.dart';
import 'package:app_rute/data/datasource/update_profile_datasources.dart';
import 'package:app_rute/presentation/onboarding_page.dart';
import 'package:app_rute/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String id = LocalDataSource.getId().toString();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(RegisterDataSource()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(LoginDataSources()),
        ),
        BlocProvider(
          create: (context) =>
              GetProfileBloc(GetProfileDataSources(LocalDataSource())),
        ),
        BlocProvider(
          create: (context) => UpdateProfileBloc(
              UpdateProfileDataSources(
                LocalDataSource(),
              ),
              id),
        ),
      ],
      child: MaterialApp(
          theme: ThemeData(
            dividerTheme: DividerThemeData(
              color: whiteColor,
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: whiteColor,
              foregroundColor: whiteColor,
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: whiteColor,
            ),
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              color: Colors.white,
              elevation: 0,
              titleTextStyle: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
              iconTheme: IconThemeData(
                color: whiteColor,
              ),
            ),
          ),
          title: 'App Rute',
          home: const OnBoardingPage()),
    );
  }
}
