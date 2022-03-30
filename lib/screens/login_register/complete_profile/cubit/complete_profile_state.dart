
abstract class CompleteProfileState {}

class CompleteProfileInitial extends CompleteProfileState {}
class SetErrorsCompleteProfile extends CompleteProfileState {}
class RemoveErrorsCompleteProfile extends CompleteProfileState {}
class SucessUploadUserInfoCompleteProfile extends CompleteProfileState {}
class ErrorUploadUserInfoCompleteProfile extends CompleteProfileState {
  String errorMsg;
  ErrorUploadUserInfoCompleteProfile(this.errorMsg);
}
class LoadingUploadUserInfoCompleteProfile extends CompleteProfileState {}
