import 'package:chat_app/screens/login_register/login_screen/login_screen.dart';
import 'package:chat_app/screens/login_register/register/cubit/register_states.dart';
import 'package:chat_app/shared/helper/methods.dart';
import 'package:chat_app/shared/helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../shared/helper/constants.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/background.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../../../../widgets/form_error.dart';
import '../cubit/register_cubit.dart';

class Body extends StatelessWidget {
  var userEmail = TextEditingController();
  String? userPassword;
  String? conform_password;
  var formKey = GlobalKey<FormState>();

  void addError({required RegisterCubit cubit, String? error}) {
    if (!cubit.errors.contains(error)) cubit.setErrors(error!);
  }

  void removeError({required RegisterCubit cubit, String? error}) {
    if (cubit.errors.contains(error)) cubit.removeErrors(error!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterSuccessSignInState) {
          Navigator.pop(context);
          Navigator.pop(context);

        } else if (state is RegisterLoadingSignInState) {
          showCustomProgressIndicator(context);
        } else if (state is RegisterFailureSignInState) {
          Navigator.pop(context);
          print(state.error);
          showSnackBar(context, state.error);
        }
      },
      builder: (context, state) {
        RegisterCubit cubit = RegisterCubit.get(context);
        return SafeArea(
          child: Background(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenHeight(20.0)),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: SizeConfig.bodyHeight * 0.06),
                      AppText(
                        text: "Register New Account",
                        isTitle: true,
                        color: Colors.black,
                        align: TextAlign.center,
                      ),
                      SizedBox(height: SizeConfig.bodyHeight * 0.03),
                      SvgPicture.asset(
                        "assets/icons/signup.svg",
                        height: SizeConfig.bodyHeight * 0.25,
                      ),
                      SizedBox(height: SizeConfig.bodyHeight * 0.04),
                      CustomTextFormField(
                        controller: userEmail,
                          type: TextInputType.emailAddress,
                          onChange: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: kEmailNullError, cubit: cubit);
                            } else if (emailValidatorRegExp.hasMatch(value)) {
                              removeError(
                                  cubit: cubit, error: kInvalidEmailError);
                            }
                            return null;
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              addError(cubit: cubit, error: kEmailNullError);
                              return "";
                            } else if (!emailValidatorRegExp.hasMatch(value)) {
                              addError(cubit: cubit, error: kInvalidEmailError);
                              return "";
                            }
                            return null;
                          },
                          lableText: 'Email Address',
                          hintText: 'Please enter your email',
                          suffixIcon: 'assets/icons/Mail.svg'),
                      SizedBox(height: SizeConfig.bodyHeight * 0.03),
                      CustomTextFormField(
                        onSaved: (newValue) => userPassword = newValue,
                        isPassword: true,
                        onChange: (value) {
                          if (value.isNotEmpty) {
                            removeError(cubit: cubit, error: kPassNullError);
                          } else if (value.length >= 8) {
                            removeError(cubit: cubit, error: kShortPassError);
                          }
                          userPassword = value;
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            addError(cubit: cubit, error: kPassNullError);
                            return "";
                          } else if (value.length < 8) {
                            addError(cubit: cubit, error: kShortPassError);
                            return "";
                          }
                          return null;
                        },
                        lableText: 'Password',
                        hintText: 'Please enter your password',
                        suffixIcon: 'assets/icons/Lock.svg',
                      ),
                      SizedBox(height: SizeConfig.bodyHeight * 0.03),
                      CustomTextFormField(
                        isPassword: true,
                        onSaved: (newValue) => conform_password = newValue,
                        onChange: (value) {
                          if (value.isNotEmpty) {
                            removeError(cubit: cubit, error: kPassNullError);
                          } else if (value.isNotEmpty &&
                              userPassword == conform_password) {
                            removeError(cubit: cubit, error: kMatchPassError);
                          }
                          conform_password = value;
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            addError(cubit: cubit, error: kPassNullError);
                            return "";
                          } else if ((userPassword != value)) {
                            addError(cubit: cubit, error: kMatchPassError);
                            return "";
                          }
                          return null;
                        },
                        lableText: 'Confirm Password',
                        hintText: 'Re-enter your password',
                        suffixIcon: 'assets/icons/Lock.svg',
                      ),
                      SizedBox(height: SizeConfig.bodyHeight * 0.01),
                      FormError(errors: cubit.errors),
                      SizedBox(height: SizeConfig.bodyHeight * 0.03),
                      CustomButton(
                        text: 'Register',
                        press: () {
                          if (formKey.currentState!.validate()) {
                            cubit.regiterNewUser(
                                context: context,
                                email: userEmail.text,
                                password: userPassword ?? '');
                          }
                        },
                      ),
                      SizedBox(height: SizeConfig.bodyHeight * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            text: 'Already have account ? ',
                            textSize: 18,
                            color: Colors.black,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: AppText(
                              text: 'Login Now ',
                              textSize: 20.0,
                              textDecoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
