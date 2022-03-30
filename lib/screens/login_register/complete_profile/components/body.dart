import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/background.dart';
import 'package:flutter/material.dart';
import '../../../../../shared/helper/size_config.dart';
import 'complete_profile_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Background(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.bodyHeight * 0.06),
                  AppText(
                    text: "Complete Profile",
                    isTitle: true,
                    color: Colors.black,
                  ),
                  SizedBox(height: SizeConfig.bodyHeight * 0.01),
                  AppText(
                    text: 'Complete your details to continue  \nwith Chat App',
                    align: TextAlign.center,
                    textSize: 16.0,
                    color: Colors.black,
                  ),
                  SizedBox(height: SizeConfig.bodyHeight * 0.06),
                  CompleteProfileForm(),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  Text(
                    "By continuing your confirm that you agree \nwith our Term and Condition",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
