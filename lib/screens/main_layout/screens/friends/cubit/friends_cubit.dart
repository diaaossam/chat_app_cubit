import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/shared/helper/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'friends_state.dart';

class FriendsCubit extends Cubit<FriendsState> {
  FriendsCubit() : super(FriendsInitial());
  List<UserModel> freindsList = [];
  StreamSubscription? streamSubscription;

  static FriendsCubit get(BuildContext context) => BlocProvider.of(context);

  void getFriends() {
    emit(GetAllFrindsStateLoading());
    FirebaseFirestore.instance.collection(USERS).get().then((value) {
      value.docs.forEach((user) {
        if (user.id != FirebaseAuth.instance.currentUser!.uid)
          freindsList.add(UserModel.fromJson(user.data()));
      });
      emit(GetAllFrindsStateSuccess());
    }).catchError((error) {
      emit(GetAllFrindsStateFaliure(errorMsg: error.toString()));
    });
  }
}
