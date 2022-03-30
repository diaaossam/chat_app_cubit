import 'package:bloc/bloc.dart';
import 'package:chat_app/screens/main_layout/cubit/main_cubit.dart';
import 'package:chat_app/screens/login_register/phone_screen/cubit/phone_cubit.dart';
import 'package:chat_app/screens/splash_screen/splash_screen.dart';
import 'package:chat_app/shared/helper/bloc_observer.dart';
import 'package:chat_app/shared/helper/methods.dart';
import 'package:chat_app/shared/services/network/dio_helper.dart';
import 'package:chat_app/shared/styles/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      Firebase.initializeApp();
      DioHelper.init();

      /*   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Message Recevied');
        print('${message.notification!.body}');
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('Message Clicked');
      });
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);*/
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext) => MainCubit()
              ..getChatList()
              ..checkToken(context)
        ),
        BlocProvider(create: (BuildContext) => PhoneCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: SplashScreen(),
      ),
    );
  }
}
