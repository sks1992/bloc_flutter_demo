import 'package:bloc_demo/bloc/cubits/internet_cubit.dart';
//import 'package:bloc_demo/bloc/internet_bloc/internet_bloc.dart';
//import 'package:bloc_demo/bloc/internet_bloc/internet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocConsumer<InternetCubit, InternetState>(
            listener: (context, state) {
              if (state == InternetState.gained) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Internet Connected"),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state == InternetState.lost) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Internet Is Not Connected."),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state == InternetState.gained) {
                return const Text("Connected");
              } else if (state == InternetState.lost) {
                return const Text("Not Internet..");
              } else {
                return const Text("Loading...");
              }
            },
          ),
        ),
        // child: Center(
        //   child: BlocBuilder<InternetBloc, InternetState>(
        //     builder: (context, state) {
        //       if (state is InternetGainedState) {
        //         return const Text("Connected");
        //       } else if (state is InternetLostState) {
        //         return const Text("Not Internet..");
        //       } else {
        //         return const Text("Loading...");
        //       }
        //     },
        //   ),
        // ),
      ),
    );
  }
}
