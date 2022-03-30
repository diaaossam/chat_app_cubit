import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'forget_state.dart';

class ForgetCubit extends Cubit<ForgetState> {
  ForgetCubit() : super(ForgetInitial());

  static ForgetCubit get(context) => BlocProvider.of(context);

  List<String> errors = [];

  void setError({required String error}) {
    errors.add(error);
    emit(SetErrorState());
  }

  void removeError({required String error}) {
    errors.remove(error);
    emit(RemoveErrorState());
  }

  void resetUserPassword({required String email}) {
    emit(SendResetEmailLoading());
    FirebaseAuth.instance.sendPasswordResetEmail(email: email)
        .then((value) {
      emit(SendResetEmailSuccess());
    }).catchError((error) {
      emit(SendResetEmailError(error.toString()));
    });
  }



}
