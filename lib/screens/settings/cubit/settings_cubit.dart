import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/shared/helper/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  UserModel? userModel;

  SettingsCubit() : super(SettingsInitial());

  static SettingsCubit get(BuildContext context) => BlocProvider.of(context);

  void getUserInfo() {
    emit(GetUserInfoLoading());
    FirebaseFirestore.instance
        .collection(USERS)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data() ?? {});
      emit(GetUserInfoSuccess());
    }).catchError((error) {
      emit(GetUserInfoFailure());
      print(error.toString());
    });
  }

  var _picker = ImagePicker();
  File? profileImage;

  Future getproductImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadImageToImage(profileImage);
    } else {
      print('No Image Selected');
    }
  }

  void uploadImageToImage(File? profileImage) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            '${USERS}/profile/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection(USERS)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'image': value});
      });
      emit(ChangeUserImage());
    }).catchError((error) {
      print(error.toString());
    });
  }
}
