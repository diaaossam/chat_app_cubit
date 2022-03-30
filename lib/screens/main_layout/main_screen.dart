import 'package:chat_app/screens/main_layout/cubit/main_cubit.dart';
import 'package:chat_app/screens/messages_screen/screens/incomming_calls_screen/in_comming_calls.dart';
import 'package:chat_app/screens/settings/settings_screen.dart';
import 'package:chat_app/shared/helper/methods.dart';
import 'package:chat_app/shared/styles/icon_broken.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/friends/friends_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        MainCubit cubit = MainCubit.get(context);

        return DefaultTabController(
          length: cubit.tabList.length,
          child: Scaffold(
              appBar: AppBar(
                title: AppText(
                  text: 'Chat App',
                  color: Colors.white,
                  isTitle: true,
                  textSize: 24,
                ),
                bottom: TabBar(
                  tabs: cubit.tabList,
                  indicatorColor: Colors.lightBlueAccent,
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        navigateTo(
                            context,
                            InCommingCallsScreen(
                              isVedio: true,
                              callerUid: '',
                            ));
                      },
                      icon: Icon(IconBroken.Search)),
                  IconButton(
                      onPressed: () {
                        navigateTo(context, SettingsScreen());
                      },
                      icon: Icon(IconBroken.Setting)),
                ],
              ),
              body: TabBarView(
                physics: BouncingScrollPhysics(),
                dragStartBehavior: DragStartBehavior.start,
                children: cubit.screenList,
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  navigateTo(context, FriendsScreen());
                },
                child: Icon(IconBroken.Chat),
              )),
        );
      },
    );
  }
}
