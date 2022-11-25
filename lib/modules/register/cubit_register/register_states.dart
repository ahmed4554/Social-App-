abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoading extends RegisterStates {}

class RegisterSuccess extends RegisterStates {}

class RegisterFailed extends RegisterStates {}

class CreateUserLoading extends RegisterStates {}

class CreateUserSuccess extends RegisterStates {
  String uId;
  CreateUserSuccess(this.uId);
}

class CreateUserFailed extends RegisterStates {
  String message;
  CreateUserFailed(this.message);
}

class ChangeModeRegister extends RegisterStates {}
