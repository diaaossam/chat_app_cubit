import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/shared/services/network/dio_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../../shared/helper/constants.dart';
import '../../../shared/styles/icon_broken.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageInitial());

  static MessageCubit get(BuildContext context) => BlocProvider.of(context);

  void sendMessage({
    required String receiver,
    required String message,
    required bool isSeen,
    required String type,
  }) {
    MessageModel messageModel = MessageModel(
        sender: getCurrentUserUid(),
        receiver: receiver,
        isSeen: isSeen,
        time: '${DateFormat.jms().format(DateTime.now())}',
        type: type,
        message: message);

    //send Message
    FirebaseFirestore.instance.collection(CHATS).add(messageModel.toMap());

    // add User to Chat Screen
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection(CHATLIST)
        .doc(CHATLIST)
        .collection(getCurrentUserUid())
        .doc("${receiver}");
    documentReference.get().then((value) {
      if (!value.exists) {
        documentReference.set({"id": receiver});
      }
    });

    //send Notifaction to user

    final data = {
      "to": "${receiver}",
      "notification": {
        "body": "'${message} ",
        "title": "New Message From User",
        "sound": "default"
      },
      "android": {
        "priority": "HIGH",
        "notification": {
          "notification_priority": "PRIORITY_HIGH",
          "sound": "default",
          "default_sound": true,
          "default_vibrate_timings": true,
          "default_light_settings": true,
        },
      },
      "data": {
        "type": "order",
        "id": "87",
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
      }
    };
    DioHelper().postData(path: 'fcm/send', data: data).then((value) {
      if (value.statusCode == 200) {
        print('Done Notification');
      }
    });
  }

/////////////////////////////////////////////////////////////////////////
  List<MessageModel> _allMessageList = [];
  List<MessageModel> userMessageList = [];

  void readMessages(String userId) {
    _allMessageList.clear();

    FirebaseFirestore.instance
        .collection(CHATS)
        .orderBy('time')
        .snapshots()
        .listen((event) {
      _allMessageList.clear();
      event.docs.forEach((message) {
        _allMessageList.add(MessageModel.fromJson(message.data()));
      });
      userMessageList = [];
      _allMessageList.forEach((message) {
        if (message.receiver == getCurrentUserUid() &&
                message.sender == userId ||
            message.receiver == userId &&
                message.sender == getCurrentUserUid()) {
          userMessageList.add(message);
        }
      });
      emit(GetMessageSuccessState());
    });
  }

  ///////////////////////////////////////////////////////////////////////////////

  var picker = ImagePicker();

  File? sentImage;

  Future getproductImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      sentImage = File(pickedFile.path);
    } else {}
  }

  String getCurrentUserUid() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  ////////////////////////////////////////////////////////////////////////////////////
}
