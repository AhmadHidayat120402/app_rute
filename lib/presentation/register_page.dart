import 'package:app_rute/bloc/register/register_bloc.dart';
import 'package:app_rute/data/models/request/register_request_model.dart';
import 'package:app_rute/presentation/login_page.dart';
import 'package:app_rute/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? usernameController;
  TextEditingController? phoneController;
  TextEditingController? passwordController;

  @override
  void initState() {
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
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          children: [
            Text(
              "Create an account",
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
                  "Register",
                  style: bgTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  "to get started with the app",
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
                controller: nameController,
                style: whiteTextStyle.copyWith(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  prefixIcon: Icon(
                    Icons.person_rounded,
                    color: bgcolor,
                  ),
                  labelText: 'Your name',
                  labelStyle: whiteTextStyle.copyWith(
                    fontSize: 14,
                  ),
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
                controller: emailController,
                style: whiteTextStyle.copyWith(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
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
                controller: usernameController,
                style: whiteTextStyle.copyWith(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  prefixIcon: Icon(
                    Icons.person_2_rounded,
                    color: bgcolor,
                  ),
                  labelText: 'Your username',
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
                controller: phoneController,
                style: whiteTextStyle.copyWith(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  prefixIcon: Icon(
                    Icons.phone,
                    color: bgcolor,
                  ),
                  labelText: 'Your Phone Number',
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
              height: 12,
            ),
            const SizedBox(
              height: 200,
            ),
            BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  loaded: (model) {
                    // Menampilkan Snackbar dan mengarahkan ke halaman login saat berhasil
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Berhasil Register"),
                        backgroundColor: bgcolor,
                      ),
                    );
                    // Redirect ke halaman login
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
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
                        final requestmodel = RegisterRequestModel(
                            name: nameController!.text,
                            email: emailController!.text,
                            username: usernameController!.text,
                            phone: phoneController!.text,
                            password: passwordController!.text);
                        context
                            .read<RegisterBloc>()
                            .add(RegisterEvent.doRegister(requestmodel));
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
                              "REGISTER",
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: Text(
                    "Login",
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
      ),
    );
  }
}
