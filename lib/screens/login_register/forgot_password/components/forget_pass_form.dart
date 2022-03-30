import 'package:chat_app/shared/helper/methods.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/helper/constants.dart';
import '../../../../shared/helper/size_config.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/form_error.dart';
import '../cubit/forget_cubit.dart';

class ForgotPassForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  var email = TextEditingController();

  void addError({required ForgetCubit cubit, String? error}) {
    if (!cubit.errors.contains(error)) cubit.setError(error: error!);
  }

  void removeError({required ForgetCubit cubit, String? error}) {
    if (cubit.errors.contains(error)) cubit.removeError(error: error!);
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetCubit, ForgetState>(
      listener: (context, state) {
        if (state is SendResetEmailLoading) {
          showCustomProgressIndicator(context);
        } else if (state is SendResetEmailError) {
          Navigator.pop(context);
          showSnackBar(context, state.errorMsg);
        } else if (state is SendResetEmailSuccess) {
          Navigator.pop(context);
          showSnackBar(context, 'Reset Eamil SentSuccessfully');
          Future.delayed(Duration(seconds: 1), () {
            Navigator.pop(context);
          });
        }
      },
      builder: (context, state) {
        ForgetCubit cubit = ForgetCubit.get(context);
        return Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                  controller: email,
                  isPassword: false,
                  onChange: (s) {
                    if (s.isNotEmpty) {
                      removeError(
                          error: kEmailNullError, cubit: cubit);
                    } else if (emailValidatorRegExp.hasMatch(s)) {
                      removeError(
                          error: kInvalidEmailError, cubit: cubit);
                    }
                    return null;
                  },
                  validate: (value) {
                    if (value!.isEmpty) {
                      addError(error: kEmailNullError, cubit: cubit);
                      return "";
                    } else if (!emailValidatorRegExp
                        .hasMatch(value)) {
                      addError(
                          error: kInvalidEmailError, cubit: cubit);
                      return "";
                    }
                    return null;
                  },
                  lableText: 'Email Address',
                  hintText: 'Please enter your email'),
              SizedBox(height: getProportionateScreenHeight(30)),
              FormError(errors: cubit.errors),
              SizedBox(height: SizeConfig.bodyHeight * 0.2),
              CustomButton(
                text: "Continue",
                press: () {
                  if (_formKey.currentState!.validate()) {
                    cubit.resetUserPassword(email: email.text);
                  }
                },
              ),
              SizedBox(height: SizeConfig.bodyHeight * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(text: 'Don’t have an account? ',textSize: 18,color: Colors.black,),
                  GestureDetector(
                    onTap: () {
                      //navigateTo(context, RegisterScreen());
                    },
                    child: AppText(
                      text: 'Sign Up',
                      textSize: 20.0,
                      textDecoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
