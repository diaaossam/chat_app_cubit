import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:chat_app/screens/main_layout/screens/calls_screen/calls_screen.dart';
import 'package:chat_app/screens/main_layout/screens/chats_screen/chats_screen.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../models/user_model.dart';
import '../../../shared/helper/constants.dart';
import '../../../shared/helper/methods.dart';
import '../screens/status_screen/status_screen.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  static MainCubit get(BuildContext context) => BlocProvider.of(context);

  ///////////////////////////////////////////////

  void checkToken(BuildContext context) {

 /*   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String uid = message.data['uid'];
      String type = "${message.notification!.title}";
     setUpCallingType(context, type, uid, true);
    });*/




/*
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
*/


    FirebaseMessaging.instance.getToken().then((token) {
      FirebaseFirestore.instance
          .collection(USERS)
          .doc(_getCurrentUserId())
          .update({
        'token': token,
      });
    });
  }

  ///////////////////////////////////////////////

  /*var _picker = ImagePicker();
  File? sentImage;

  Future getproductImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      sentImage = File(pickedFile.path);
    } else {
      print('no');
    }
  }*/


/////////////////////////////////////////////////////
  List<Tab> tabList = [
    Tab(text: 'CHAT'),
    Tab(text: 'STATUS'),
    Tab(text: 'CALLS'),
  ];

  List<Widget> screenList = [
    ChatsScreen(),
    StatusScreen(),
    CallsScreen(),
  ];

  //////////////////////////////////

  void getChatList() {
    FirebaseFirestore.instance.collection(USERS).get().then((value) {
      value.docs.forEach((users) {
        FirebaseFirestore.instance
            .collection(CHATLIST)
            .doc(CHATLIST)
            .collection(_getCurrentUserId())
            .get()
            .then((value) {
          value.docs.forEach((chat) {
            if (users.id == chat.id) {
              getUser(users.id);
            }
          });
        });
      });
    });
  }

  List<UserModel> userList = [];

  void getUser(String id) {
    userList.clear();
    FirebaseFirestore.instance.collection(USERS).doc(id).get().then((value) {
      userList.add(UserModel.fromJson(value.data() ?? {}));
    }).then((value) {
      emit(SetChatListState());
    });
  }

////////////////////////////////////////

  String _getCurrentUserId() {
    return FirebaseAuth.instance.currentUser!.uid;
  }
}
