import 'package:bloc_demo/sign_in/bloc/sign_in_bloc.dart';
import 'package:bloc_demo/sign_in/bloc/sign_in_event.dart';
import 'package:bloc_demo/sign_in/bloc/sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in with email"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
                if (state is SignInErrorState) {
                  return Text(
                    state.errorMessage,
                    style: const TextStyle(color: Colors.red),
                  );
                } else {
                  return Container();
                }
              }),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(hintText: "Email Address"),
                onChanged: (val) {
                  BlocProvider.of<SignInBloc>(context).add(
                      SignInTextChangeEvent(
                          emailController.text, passController.text));
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passController,
                decoration: const InputDecoration(hintText: "Password"),
                onChanged: (val) {
                  BlocProvider.of<SignInBloc>(context).add(
                      SignInTextChangeEvent(
                          emailController.text, passController.text));
                },
              ),
              const SizedBox(height: 16),
              BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
                if (state is SignInLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: state is SignInValidState
                          ? Colors.blue
                          : Colors.grey),
                  onPressed: () {
                    BlocProvider.of<SignInBloc>(context).add(
                        SignInSubmittedEvent(
                            emailController.text, passController.text));
                  },
                  child: const Text("Sign IN"),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
