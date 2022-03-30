import 'package:bloc/bloc.dart';
import 'package:chat_app/screens/login_register/phone_screen/cubit/phone_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/helper/constants.dart';
import '../../../../shared/helper/methods.dart';



class PhoneCubit extends Cubit<PhoneState> {

  PhoneCubit() : super(PhoneInitial());

  static PhoneCubit get(context) => BlocProvider.of(context);

  late String verificationId;

  Future<void> submitPhoneNumber(String phone) async {
    emit(Loading());
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '${phone} ',
        timeout: const Duration(seconds: 14),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print('verificationCompleted');
    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException error) {
    print('verificationFailed : ${error.toString()}');
    emit(ErrorOccurred(errorMsg: error.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    this.verificationId = verificationId;
    emit(PhoneNumberSubmited());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
  }

  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: this.verificationId, smsCode: otpCode);
    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential).then((value){
        checkUserInfo();
      });
    } catch (error) {
      emit(ErrorOccurred(errorMsg: error.toString()));
    }
  }

  void checkUserInfo() {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance.collection(USERS).doc(uid).get().then((value) {
      if (value.exists) {
        emit(PhoneOTPVerifiedMainLayout());
      } else {
        emit(PhoneOTPVerifiedCompleteProfile());
      }
    });
  }
}


