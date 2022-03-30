import 'package:chat_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import '../../../../../shared/helper/size_config.dart';
import 'forget_pass_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.bodyHeight * 0.04),
              AppText(
                text: "Forgot Password",
                textSize: getProportionateScreenWidth(28),
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              AppText(
                text:
                    "Please enter your email and we will send \nyou a link to return to your account",
                align: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.bodyHeight * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}
