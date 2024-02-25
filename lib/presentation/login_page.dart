import 'package:app_rute/bloc/login/login_bloc.dart';
import 'package:app_rute/data/datasource/local_datasources.dart';
import 'package:app_rute/data/models/request/login_request_model.dart';
import 'package:app_rute/presentation/bottom_navigasi.dart';
import 'package:app_rute/presentation/register_page.dart';
import 'package:app_rute/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    checkAuth();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailController!.dispose();
    passwordController!.dispose();
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
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          children: [
            Text(
              "Hello You!",
              style: whiteTextStyle.copyWith(
                fontWeight: bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Text(
                  "Login",
                  style: bgTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  "if you already have an account",
                  style: whiteTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
                style: whiteTextStyle.copyWith(fontSize: 14),
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: bgcolor,
                  ),
                  labelText: 'Your Email',
                  labelStyle: whiteTextStyle.copyWith(fontSize: 14),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: bgcolor),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
                controller: passwordController,
                style: whiteTextStyle.copyWith(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: bgcolor,
                  ),
                  labelText: 'Your Password',
                  labelStyle: whiteTextStyle.copyWith(fontSize: 14),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: bgcolor),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(
              height: 385,
            ),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  loaded: (model) {
                    LocalDataSource().saveToken(model.token.toString());
                    LocalDataSource.saveId("${model.user?.id}");
                    LocalDataSource.saveNama("${model.user?.name}");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Berhasil Login"),
                        backgroundColor: bgcolor,
                      ),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavigasi(),
                      ),
                    );
                  },
                  error: (message) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return InkWell(
                      onTap: () {
                        final requestModel = LoginRequestModel(
                            email: emailController!.text,
                            password: passwordController!.text);
                        context
                            .read<LoginBloc>()
                            .add(LoginEvent.doLogin(requestModel));
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: bgcolor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "LOGIN",
                              style: whiteTextStyle.copyWith(
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
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "I don't have an account",
                  style: whiteTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const RegisterPage();
                    }));
                  },
                  child: Text(
                    "Register",
                    style: bgTextStyle.copyWith(
                      fontWeight: bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       const Center(child: Text("Login")),
        //       const SizedBox(
        //         height: 16,
        //       ),
        //       TextField(
        //         controller: emailController,
        //         decoration: const InputDecoration(
        //           labelText: "Email",
        //         ),
        //       ),
        //       TextField(
        //         controller: passwordController,
        //         decoration: const InputDecoration(
        //           labelText: "Password",
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 16,
        //       ),
        //       BlocConsumer<LoginBloc, LoginState>(
        //         listener: (context, state) {
        //           state.maybeWhen(
        //             orElse: () {},
        //             loaded: (model) {
        //               LocalDataSource().saveToken(model.token.toString());
        //               LocalDataSource.saveId("${model.user?.id}");
        //               ScaffoldMessenger.of(context).showSnackBar(
        //                 const SnackBar(
        //                   content: Text("Berhasil Login"),
        //                   backgroundColor: Colors.blue,
        //                 ),
        //               );
        //               Navigator.pushReplacement(
        //                 context,
        //                 MaterialPageRoute(
        //                   builder: (context) => const BottomNavigasi(),
        //                 ),
        //               );
        //             },
        //             error: (message) {
        //               ScaffoldMessenger.of(context).showSnackBar(
        //                 SnackBar(
        //                   content: Text(message),
        //                   backgroundColor: Colors.red,
        //                 ),
        //               );
        //             },
        //           );
        //         },
        //         builder: (context, state) {
        //           return state.maybeWhen(
        //             orElse: () => ElevatedButton(
        //               onPressed: () {
        //                 final requestModel = LoginRequestModel(
        //                     email: emailController!.text,
        //                     password: passwordController!.text);
        //                 context
        //                     .read<LoginBloc>()
        //                     .add(LoginEvent.doLogin(requestModel));
        //               },
        //               child: const Text("Login"),
        //             ),
        //             loading: () => const Center(
        //               child: CircularProgressIndicator(),
        //             ),
        //           );
        //         },
        //       ),
        //       const SizedBox(
        //         height: 8,
        //       ),
        //       InkWell(
        //           onTap: () {
        //             Navigator.push(context,
        //                 MaterialPageRoute(builder: (context) {
        //               return const RegisterPage();
        //             }));
        //           },
        //           child: const Text("Belum Punya Akun ? Register"))
        //     ],
        //   ),
        // )),
      ),
    );
  }
}
