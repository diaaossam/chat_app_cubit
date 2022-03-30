import 'package:chat_app/screens/messages_screen/screens/incomming_calls_screen/cubit/in_comming_calls_cubit.dart';
import 'package:chat_app/shared/helper/size_config.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:chat_app/shared/styles/icon_broken.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InCommingCallsScreen extends StatelessWidget {
  String callerUid;
  bool isVedio;

  InCommingCallsScreen({required this.callerUid, required this.isVedio});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InCommingCallsCubit>(
      create: (BuildContext context) =>
          InCommingCallsCubit()..setupCallerInfo(callerUid),
      child: BlocConsumer<InCommingCallsCubit, InCommingCallsState>(
        listener: (context, state) {},
        builder: (context, state) {
          InCommingCallsCubit cubit = InCommingCallsCubit.get(context);
          return Scaffold(
            body: state is GetUserInfoStateLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: Background(
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              height: SizeConfig.bodyHeight * 0.05,
                            ),
                            Padding(
                              padding: EdgeInsets.all(
                                  getProportionateScreenHeight(20)),
                              child: Row(
                                children: [
                                  Icon(
                                      isVedio
                                          ? IconBroken.Video
                                          : IconBroken.Voice,
                                      color: kPrimaryColor,
                                      size: getProportionateScreenHeight(40.0)),
                                  SizedBox(
                                    width: getProportionateScreenHeight(5.0),
                                  ),
                                  AppText(
                                      text:
                                          isVedio ? 'Vedio Chat' : 'Voice Chat',
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
                                text: '${cubit.userModel!.phone}',
                                color: kPrimaryColor,
                                textSize: 25.0,
                                fontWeight: FontWeight.w400),
                            SizedBox(
                              height: getProportionateScreenHeight(15.0),
                            ),
                            CircleAvatar(
                              radius: getProportionateScreenHeight(80),
                              child: Image(
                                image: cubit.userModel!.image == 'DEFULT'
                                    ? AssetImage('assets/images/user.png')
                                    : NetworkImage('${cubit.userModel!.image}')
                                        as ImageProvider,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(15.0),
                            ),
                            AppText(
                                text:
                                    '${cubit.userModel!.firstName} ${cubit.userModel!.lastName}',
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
                              child: Row(children: [
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    child: CircleAvatar(
                                      radius: SizeConfig.bodyHeight * 0.05,
                                      backgroundColor: Colors.greenAccent,
                                      child: Icon(
                                        Icons.call,
                                        size: SizeConfig.bodyHeight * 0.05,
                                        color: Colors.white,
                                      ),
                                    ),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {},
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
                              ]),
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
