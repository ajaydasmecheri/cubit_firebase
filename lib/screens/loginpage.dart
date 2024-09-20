import 'package:cubit/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'homepage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();

    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const Homepage()));
          } else if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: email,
              decoration: const InputDecoration(hintText: "Email"),
            ),
            TextFormField(
              controller: password,
              decoration: const InputDecoration(hintText: "Password"),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<LoginCubit>(context).userLogin(email.text.trim(), password.text.trim());
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
