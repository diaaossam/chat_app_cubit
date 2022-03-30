part of 'forget_cubit.dart';

@immutable
abstract class ForgetState {}

class ForgetInitial extends ForgetState {}
class SetErrorState extends ForgetState {}
class RemoveErrorState extends ForgetState {}
class SendResetEmailSuccess extends ForgetState {}
class SendResetEmailError extends ForgetState {
  String errorMsg;

  SendResetEmailError(this.errorMsg);
}
class SendResetEmailLoading extends ForgetState {}
