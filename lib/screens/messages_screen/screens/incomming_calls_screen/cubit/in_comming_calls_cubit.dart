import 'package:bloc/bloc.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/shared/helper/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'in_comming_calls_state.dart';

class InCommingCallsCubit extends Cubit<InCommingCallsState> {
  UserModel? userModel;

  InCommingCallsCubit() : super(InCommingCallsInitial());

  static InCommingCallsCubit get(BuildContext context) =>
      BlocProvider.of(context);

  void setupCallerInfo(String uid) {
    emit(GetUserInfoStateLoading());
    FirebaseFirestore.instance.collection(USERS).doc(uid).get().then((value) {
      userModel = UserModel.fromJson(value.data() ?? {});
      emit(GetUserInfoStateSuccess());
    });
  }
}
