import 'package:chat_app/screens/main_layout/main_screen.dart';
import 'package:chat_app/screens/login_register/register/register_screen.dart';
import 'package:chat_app/widgets/background.dart';
import 'package:chat_app/screens/login_register/login_screen/cubit/login_state.dart';
import 'package:chat_app/shared/helper/methods.dart';
import 'package:chat_app/shared/helper/size_config.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/helper/constants.dart';
import '../../../../shared/styles/colors.dart';
import '../../../../widgets/form_error.dart';
import '../../../../widgets/or_divider.dart';
import '../../../../widgets/social_card.dart';
import '../../complete_profile/complete_profile_screen.dart';
import '../../forgot_password/forgot_password_screen.dart';
import '../../phone_screen/phone_screen.dart';
import '../cubit/login_cubit.dart';

class Body extends StatelessWidget {
  var email = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var password = TextEditingController();

  void addError({required LoginCubit cubit, String? error}) {
    if (!cubit.errors.contains(error)) cubit.setErrors(error!);
  }

  void removeError({required LoginCubit cubit, String? error}) {
    if (cubit.errors.contains(error)) cubit.removeErrors(error!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if(state is SignInLoadingState){
            showCustomProgressIndicator(context);
          }
          else if(state is SignInFailuerState){
            Navigator.pop(context);
            showSnackBar(context, state.error);
          }
          else if(state is SignInSuccessStateCompletetProfile){
            Navigator.pop(context);
            navigateToAndFinish(context,CompleteProfileScreen());
          }
          else if(state is SignInSuccessStateMainLayout){
            Navigator.pop(context);
            navigateToAndFinish(context,MainScreen());
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
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
                          text:
                              "Sign in with your email and password  \nor continue with social media",
                          textSize: 22,
                          align: TextAlign.center,
                        ),
                        SizedBox(height: SizeConfig.bodyHeight * 0.02),
                        SvgPicture.asset(
                          "assets/icons/login.svg",
                          height: SizeConfig.bodyHeight * 0.25,
                        ),
                        SizedBox(height: SizeConfig.bodyHeight * 0.02),
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
                            hintText: 'Please enter your email',
                            suffixIcon: 'assets/icons/Mail.svg'),
                        SizedBox(height: SizeConfig.bodyHeight * 0.03),
                        CustomTextFormField(
                          controller: password,
                          isPassword: !cubit.isPasswordVisible,
                          onChange: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: kPassNullError, cubit: cubit);
                            } else if (value.length >= 8) {
                              removeError(error: kShortPassError, cubit: cubit);
                            }
                            return null;
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              addError(error: kPassNullError, cubit: cubit);
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
                        SizedBox(height: SizeConfig.bodyHeight * 0.01),
                        FormError(errors: cubit.errors),
                        Row(
                          children: [
                            Checkbox(
                              value: cubit.isPasswordVisible,
                              activeColor: kPrimaryColor,
                              onChanged: (value) {
                                cubit.changePasswordVisibaltySignIn();
                              },
                            ),
                            AppText(
                                text: 'Show Password',
                                color: Colors.black,
                                textSize: 17.0),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                navigateTo(context, ForgotPasswordScreen());
                              },
                              child: AppText(
                                text: 'Forgot Password',
                                color: Colors.black,
                                textSize: 17.0,
                                textDecoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: SizeConfig.bodyHeight * 0.03),
                        CustomButton(
                          text: 'Login',
                          press: () {
                            if (formKey.currentState!.validate()) {
                              cubit.signInWithEmailAndPassword(
                                  email: email.text, password: password.text);
                            }
                          },
                        ),
                        SizedBox(height: SizeConfig.bodyHeight * 0.03),
                        OrDivider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocialCard(
                              icon: "assets/icons/google-icon.svg",
                              press: () {
                                LoginCubit.get(context).signInWithGoogle();
                              },
                            ),
                            SocialCard(
                              icon: "assets/icons/facebook-2.svg",
                              press: () {
                                LoginCubit.get(context).signInWithFacebook();
                              },
                            ),
                            SocialCard(
                              icon: "assets/icons/Phone.svg",
                              press: () {
                                navigateTo(context, PhoneVerifactionScreen());
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                              text: 'Don’t have an account? ',
                              textSize: 18,
                              color: Colors.black,
                            ),
                            GestureDetector(
                              onTap: () {
                                navigateTo(context, RegisterScreen());
                              },
                              child: AppText(
                                text: 'Register Now',
                                textSize: 18.0,
                                textDecoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
