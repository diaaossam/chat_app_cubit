import 'package:chat_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/body.dart';
import 'cubit/forget_cubit.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: AppText(text: 'Forgot Password'),
        ),
        body: Body(),
      ),
    );
  }
}
