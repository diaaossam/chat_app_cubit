import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/screens/messages_screen/componets/message_design.dart';
import 'package:chat_app/screens/messages_screen/cubit/message_cubit.dart';
import 'package:chat_app/screens/messages_screen/screens/outcomming_call_screen/out_comming_call_screen.dart';
import 'package:chat_app/shared/helper/methods.dart';
import 'package:chat_app/shared/helper/size_config.dart';
import 'package:chat_app/shared/styles/colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../shared/styles/icon_broken.dart';
import 'componets/custom_bottom_menu.dart';

class MessageScreen extends StatelessWidget {
  UserModel userModel;

  MessageScreen({required this.userModel});

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageCubit()..readMessages(userModel.uid ?? ''),
      child: BlocConsumer<MessageCubit, MessageState>(
        listener: (context, state) {},
        builder: (context, state) {
          MessageCubit cubit = MessageCubit.get(context);
          FirebaseMessaging.onMessage.listen((RemoteMessage message) {

            setUpCallingType(
                userModel: userModel,
                context: context,
                isCancel: message.data['cancel'],
                title: message.notification!.title??'',
                uid: message.data['uid'],
                isRequest: true
            );
          });

          FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
            setUpCallingType(
                context: context,
                isCancel: message.data['cancel'],
                title: message.notification!.title??'',
                uid: message.data['uid'],
                isRequest: true, userModel: userModel
            );

            FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

          });


          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image(
                      image: NetworkImage('${userModel.image}'),
                      height: getProportionateScreenHeight(35.0),
                      width: getProportionateScreenHeight(35.0),
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenHeight(10.0),
                  ),
                  AppText(
                    text: '${userModel.firstName}',
                    color: Colors.white,
                    textSize: 24,
                  ),
                ],
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(
                          context,
                          OutCommingCallsScreen(
                              userModel: userModel, isVedio: false));
                    },
                    icon: Icon(IconBroken.Call)),
                IconButton(
                    onPressed: () {
                      navigateTo(
                          context,
                          OutCommingCallsScreen(
                              userModel: userModel, isVedio: true));
                    },
                    icon: Icon(IconBroken.Video)),
              ],
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: const AssetImage(
                          'assets/images/chat_background.jpg'))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: cubit.userMessageList.length,
                        itemBuilder: (context, index) {
                          return MessageDesign(
                              isMyMessage:
                                  cubit.userMessageList[index].sender ==
                                          cubit.getCurrentUserUid()
                                      ? true
                                      : false,
                              time: cubit.userMessageList[index].time,
                              message:
                                  cubit.userMessageList[index].message ?? '');
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(5)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: getProportionateScreenHeight(6.0)),
                            child: Container(
                              height: SizeConfig.bodyHeight * 0.075,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              getProportionateScreenHeight(
                                                  20.0)),
                                      child: TextFormField(
                                        controller: messageController,
                                        decoration: InputDecoration(
                                            hintText: 'Message',
                                            focusedBorder: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (context) =>
                                              CustomBottomMenu(),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.attach_file,
                                        color: Colors.grey,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenHeight(6)),
                          child: InkWell(
                            onTap: () {
                              cubit.sendMessage(
                                  receiver: '${userModel.uid}',
                                  message: messageController.text,
                                  isSeen: false,
                                  type: 'text');
                              messageController.clear();
                            },
                            child: CircleAvatar(
                                radius: getProportionateScreenHeight(27.0),
                                backgroundColor: kPrimaryColor,
                                child: const Icon(
                                  IconBroken.Send,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
