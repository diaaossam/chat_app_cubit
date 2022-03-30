import 'package:chat_app/screens/messages_screen/screens/outcomming_call_screen/cubit/out_comming_calls_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/user_model.dart';
import '../../../../shared/helper/size_config.dart';
import '../../../../shared/styles/colors.dart';
import '../../../../shared/styles/icon_broken.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/background.dart';

class OutCommingCallsScreen extends StatelessWidget {
  UserModel userModel;
  bool isVedio;

  OutCommingCallsScreen({required this.userModel, required this.isVedio});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OutCommingCallsCubit>(
      create: (BuildContext context) => OutCommingCallsCubit()
        ..setupCall(
            uid: '${userModel.uid}',
            isVedio: isVedio,
            isCancel: false,
            receiverToken: '${userModel.token}',
            userName: '${userModel.firstName} ${userModel.lastName}'),

      child: BlocConsumer<OutCommingCallsCubit, OutCommingCallsState>(
        listener: (context, state) {},
        builder: (context, state) {
          OutCommingCallsCubit cubit = OutCommingCallsCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Background(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.bodyHeight * 0.05,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.all(getProportionateScreenHeight(20)),
                        child: Row(
                          children: [
                            Icon(isVedio ? IconBroken.Video : IconBroken.Voice,
                                color: kPrimaryColor,
                                size: getProportionateScreenHeight(40.0)),
                            SizedBox(
                              width: getProportionateScreenHeight(5.0),
                            ),
                            AppText(
                                text: isVedio ? 'Vedio Chat' : 'Voice Chat',
                                color: kPrimaryColor,
                                textSize: 22.0,
                                fontWeight: FontWeight.w500),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.bodyHeight * 0.13,
                      ),
                      AppText(
                          text: '${userModel.phone}',
                          color: kPrimaryColor,
                          textSize: 25.0,
                          fontWeight: FontWeight.w400),
                      SizedBox(
                        height: getProportionateScreenHeight(15.0),
                      ),
                      CircleAvatar(
                        radius: getProportionateScreenHeight(80),
                        child: Image(
                          image: userModel.image != 'DEFULT'
                              ? NetworkImage('${userModel.image}')
                              : AssetImage('assets/images/user.png')
                                  as ImageProvider,
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15.0),
                      ),
                      AppText(
                          text: '${userModel.firstName} ${userModel.lastName}',
                          color: kPrimaryColor,
                          textSize: 28.0,
                          fontWeight: FontWeight.w600),
                      SizedBox(
                        height: getProportionateScreenHeight(10.0),
                      ),
                      AppText(
                          text: 'Is Calling you ',
                          color: kPrimaryColor,
                          textSize: 25.0,
                          fontWeight: FontWeight.w400),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.bodyHeight * 0.1,
                            right: SizeConfig.bodyHeight * 0.1,
                            bottom: SizeConfig.bodyHeight * 0.1),
                        child: InkWell(
                          onTap: () {
                            cubit.setupCall(
                                uid: '${userModel.uid}',
                                isVedio: isVedio,
                                isCancel: true,
                                receiverToken: '${userModel.token}',
                                userName: '${userModel.firstName} ${userModel.lastName}');
                          },
                          child: Container(
                            child: CircleAvatar(
                              radius: SizeConfig.bodyHeight * 0.05,
                              backgroundColor: Colors.red,
                              child: Icon(
                                Icons.call_end,
                                size: SizeConfig.bodyHeight * 0.05,
                                color: Colors.white,
                              ),
                            ),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ],
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
