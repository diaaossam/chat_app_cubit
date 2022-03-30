abstract class RegisterStates{}
 class InitialRegisterStates extends RegisterStates{}

class RegisterSuccessSignInState extends RegisterStates{}
class RegisterFailureSignInState extends RegisterStates{
  final String error;

  RegisterFailureSignInState(this.error);
}
class RegisterLoadingSignInState extends RegisterStates{}

class SetErrorsRegisterState extends RegisterStates{}
class RemoveErrorsRegisterState extends RegisterStates{}