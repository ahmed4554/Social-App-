abstract class SocialAppStates {}

class SocialAppInitialState extends SocialAppStates {}

class LoadingLoginState extends SocialAppStates {}

class LoginSucces extends SocialAppStates {
  String uId;
  LoginSucces(this.uId);
}

class LoginFailed extends SocialAppStates {
  String message;

  LoginFailed(this.message);
}

class ChangeMode extends SocialAppStates {}
