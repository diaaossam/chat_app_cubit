import 'package:bloc/bloc.dart';
import 'package:chat_app/screens/login_register/login_screen/cubit/login_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../../shared/helper/constants.dart';
import '../../../../shared/helper/methods.dart';


class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(SignInInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPasswordVisible = false;

  void changePasswordVisibaltySignIn() {
    isPasswordVisible = !isPasswordVisible;
    emit(ChangePasswordVisibilty());
  }

  final List<String?> errors = [];

  void setErrors(String error) {
    errors.add(error);
    print(errors.length);
    emit(SetErrorsLoginState());
  }

  void removeErrors(String error) {
    errors.remove(error);
    print(errors.length);
    emit(RemoveErrorsLoginState());
  }

  void signInWithGoogle() async {
    emit(SignInLoadingState());
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {

      checkUserInfo();
    }).catchError((error) {
      emit(SignInFailuerState(error.toString()));
    });
  }

  Future signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(SignInLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      checkUserInfo();
    }).catchError((error) {
      print(error.toString());
      emit(SignInFailuerState(error.toString()));
    });
  }

  void signInWithFacebook() async {
    emit(SignInLoadingState());

    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential)
        .then((value) {
      checkUserInfo();
    }).catchError((error) {
      emit(SignInFailuerState(error.toString()));
    });
  }



  void checkUserInfo() {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance.collection(USERS).doc(uid).get().then((value) {
      if (value.exists) {
        emit(SignInSuccessStateMainLayout());
      } else {
        emit(SignInSuccessStateCompletetProfile());
      }
    });
  }
}
