import 'package:chat_app/screens/login_register/complete_profile/complete_profile_screen.dart';
import 'package:chat_app/screens/login_register/login_screen/login_screen.dart';
import 'package:chat_app/screens/splash_screen/cubit/splash_cubit.dart';
import 'package:chat_app/shared/helper/methods.dart';
import 'package:chat_app/shared/helper/size_config.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/background.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../main_layout/main_screen.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => SplashCubit()..checkUserState(context),
      child: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if(state is SplashLoginState){
            navigateToAndFinish(context, LoginScreen());
          }
          else if(state is SplashCompleteProfileState){
            navigateToAndFinish(context, CompleteProfileScreen());
          }
          else if(state is SplashMainLayoutState){
            navigateToAndFinish(context, MainScreen());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Background(
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.bodyHeight * 0.3),
                    AppText(text: 'Welcome To Chat App',isTitle: true,color: Colors.black,),
                    SizedBox(height: getProportionateScreenHeight(25.0)),
                    Center(
                      child: Container(
                          width: getProportionateScreenHeight(250.0),
                          height: getProportionateScreenHeight(250.0),
                          child: Lottie.asset('assets/logo/logo.json')
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(25.0)),
                    AppText(text: 'Connect To All People'),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: getProportionateScreenHeight(15.0)),
                      child: Center(child: CircularProgressIndicator(),),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
