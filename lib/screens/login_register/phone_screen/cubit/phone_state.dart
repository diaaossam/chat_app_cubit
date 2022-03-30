
abstract class PhoneState {}

class PhoneInitial extends PhoneState {}
class LastPageViewPhone extends PhoneState {}

class Loading extends PhoneState {}

class ErrorOccurred extends PhoneState {
  final String errorMsg;
  ErrorOccurred({required this.errorMsg});
}

class PhoneNumberSubmited extends PhoneState{}

class PhoneOTPVerifiedCompleteProfile extends PhoneState{}
class PhoneOTPVerifiedMainLayout extends PhoneState{}
