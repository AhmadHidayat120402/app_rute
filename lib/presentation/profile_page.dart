import 'package:app_rute/bloc/get_profile/get_profile_bloc.dart';
import 'package:app_rute/bloc/update_profile/update_profile_bloc.dart';
import 'package:app_rute/data/datasource/local_datasources.dart';
import 'package:app_rute/data/models/request/profile_request_model.dart';
import 'package:app_rute/presentation/bottom_navigasi.dart';
import 'package:app_rute/presentation/login_page.dart';
import 'package:app_rute/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? usernameController;
  TextEditingController? phoneController;
  TextEditingController? passwordController;

  late GetProfileBloc getProfileBloc;

  @override
  void initState() {
    getProfileBloc = context.read<GetProfileBloc>();
    getProfileBloc.add(const GetProfileEvent.getProfile());
    nameController = TextEditingController();
    emailController = TextEditingController();
    usernameController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController!.dispose();
    emailController!.dispose();
    usernameController!.dispose();
    phoneController!.dispose();
    passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: blackColor, size: 30),
        backgroundColor: whiteColor.withOpacity(0.9),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => const ShowDialogLogout());
            },
            icon: Icon(
              Icons.logout,
              color: blackColor,
            ),
          ),
        ],
        title: const Center(child: Text("Profile")),
        elevation: 5,
      ),
      body: BlocConsumer<GetProfileBloc, GetProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const SizedBox();
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (model) {
              nameController?.text = model.name.toString();
              emailController?.text = model.email.toString();
              usernameController?.text = model.username.toString();
              phoneController?.text = model.phone.toString();

              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: semiBold,
                          ),
                          decoration: const InputDecoration(
                            labelText: "Name",
                          ),
                        ),
                        TextField(
                          controller: emailController,
                          style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: semiBold,
                          ),
                          decoration: const InputDecoration(labelText: 'Email'),
                        ),
                        TextField(
                          controller: usernameController,
                          style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: semiBold,
                          ),
                          decoration:
                              const InputDecoration(labelText: 'Username'),
                        ),
                        TextField(
                          controller: phoneController,
                          style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: semiBold,
                          ),
                          decoration: const InputDecoration(labelText: 'Phone'),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        BlocConsumer<UpdateProfileBloc, UpdateProfileState>(
                          listener: (context, state) {
                            state.maybeWhen(
                              orElse: () {},
                              loaded: (model) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Berhasil Ubah Data"),
                                    backgroundColor:
                                        Color.fromARGB(255, 12, 222, 237),
                                  ),
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const BottomNavigasi(),
                                  ),
                                );
                              },
                              error: (message) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(message),
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            );
                          },
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () {
                                return InkWell(
                                  onTap: () async {
                                    final requestModel = ProfileRequestModel(
                                        email: emailController!.text,
                                        name: nameController!.text,
                                        phone: phoneController!.text,
                                        username: usernameController!.text);
                                    final String id =
                                        await LocalDataSource.getId();
                                    context.read<UpdateProfileBloc>().add(
                                        UpdateProfileEvent.updateProfile(
                                            requestModel, id));
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
                                          "Ubah Data",
                                          style: bgTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: semiBold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ShowDialogLogout extends StatelessWidget {
  const ShowDialogLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      title: Text("Logout", style: blackTextStyle.copyWith(fontWeight: bold)),
      content: Text(
        "Apakah anda ingin logout ? ",
        style: blackTextStyle.copyWith(fontWeight: bold),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: () async {
            await LocalDataSource().removeToken();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return const LoginPage();
            }));
          },
          child: const Text(
            'Ok',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
