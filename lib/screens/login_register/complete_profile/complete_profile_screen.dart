import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/body.dart';
import 'cubit/complete_profile_cubit.dart';

class CompleteProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompleteProfileCubit(),
      child: Scaffold(
        body: Body(),
      ),
    );
  }
}
