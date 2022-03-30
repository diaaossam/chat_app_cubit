import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../shared/helper/constants.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  static SplashCubit get(BuildContext context) => BlocProvider.of(context);

  void checkUserState(context) {
    Future.delayed(Duration(seconds: 3), () {
      FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user != null) {
          FirebaseFirestore.instance
              .collection(USERS)
              .doc(user.uid)
              .get()
              .then((value) {
            if (value.exists) {
              emit(SplashMainLayoutState());
            } else {
              emit(SplashCompleteProfileState());
            }
          });
        } else {
          emit(SplashLoginState());
        }
      });
    });
  }
}
