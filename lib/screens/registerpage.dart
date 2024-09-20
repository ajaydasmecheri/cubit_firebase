import 'package:cubit/register/register_cubit.dart';
import 'package:cubit/screens/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();

    return Scaffold(
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
          } else if (state is RegisterError) {
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
                BlocProvider.of<RegisterCubit>(context).userRegister(email.text.trim(), password.text.trim());
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}
