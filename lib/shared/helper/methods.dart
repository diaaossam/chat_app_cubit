import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/screens/messages_screen/message_screen.dart';
import 'package:chat_app/screens/messages_screen/screens/incomming_calls_screen/cubit/in_comming_calls_cubit.dart';
import 'package:chat_app/screens/messages_screen/screens/incomming_calls_screen/in_comming_calls.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../styles/colors.dart';
import 'constants.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

void navigateToWithAnimation(context, widget) {
  Navigator.push(
      context,
      PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (context, animation, _) {
            return FadeTransition(
              opacity: animation,
              child: widget,
            );
          }));
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(' firebaseMessagingBackground  ${message.data['uid']}');
}

void setUpCallingType(
    {required BuildContext context,
    required String title,
    required UserModel userModel,
    required String uid,
    required bool isCancel,
    required bool isRequest}) {
  if (title.contains('Vedio') && isCancel == false) {
    navigateTo(context, InCommingCallsScreen(callerUid: uid, isVedio: true));
  } else if (title.contains('Voice') && isCancel == false) {
    navigateTo(context, InCommingCallsScreen(callerUid: uid, isVedio: false));
  } else if (isCancel) {
    navigateTo(context, MessageScreen(userModel: userModel));
  }
}

void genrateToken(String uid) {
  FirebaseMessaging.instance.getToken().then((token) {
    FirebaseFirestore.instance.collection(USERS).doc(uid).update({
      'token': token,
    });
  });
}

void showSnackBar(BuildContext context, String errorMsg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(errorMsg),
    backgroundColor: Colors.black,
    duration: Duration(seconds: 5),
  ));
}

void showCustomProgressIndicator(BuildContext context) {
  AlertDialog alertDialog = AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
      ),
    ),
  );

  showDialog(
    barrierColor: Colors.white.withOpacity(0),
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return alertDialog;
    },
  );
}
