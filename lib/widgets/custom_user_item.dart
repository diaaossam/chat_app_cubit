import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/screens/messages_screen/message_screen.dart';
import 'package:chat_app/shared/helper/methods.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../shared/helper/size_config.dart';
import '../shared/styles/icon_broken.dart';

class CustomUserItem extends StatelessWidget {
  UserModel userModel;

  CustomUserItem({required this.userModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

        navigateToWithAnimation(context, MessageScreen(userModel: userModel));
      },
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                backgroundColor: kPrimaryColor,
                radius: getProportionateScreenHeight(37.0),
              ),
              CircleAvatar(
                child: Image(
                  height: getProportionateScreenHeight(50),
                  width: getProportionateScreenHeight(50),
                  image: NetworkImage('${userModel.image}'),
                ),
                backgroundColor: Colors.white,
                radius: getProportionateScreenHeight(35.0),
              ),
            ],
          ),
          SizedBox(
            width: getProportionateScreenHeight(10.0),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: '${userModel.firstName}',
              ),
              SizedBox(
                height: getProportionateScreenHeight(4.0),
              ),
              AppText(text: '${userModel.bio}', textSize: 16, color: Colors.black45),
            ],
          ),
        ],
      ),
    );
  }
}
