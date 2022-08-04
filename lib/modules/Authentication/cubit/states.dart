abstract class AuthenticationStates {}

class AuthenticationInitialState extends AuthenticationStates {}

// all states exist in LogIn screen and Register screen
class AddUserChangePasswordVisibilityState extends AuthenticationStates {}

class AddUserChangeRadioButton extends AuthenticationStates {}

class AddUserProfileImagePickedSuccessState extends AuthenticationStates {}

class AddUserProfileImagePickedErrorState extends AuthenticationStates {}

// SingUp with email and password user states
class SignUpLoadingState extends AuthenticationStates {}

class SignUpSuccessState extends AuthenticationStates {}

class SignUpErrorState extends AuthenticationStates {
  final String error;

  SignUpErrorState(this.error);
}

// Create user states
class CreateUserLoadingState extends AuthenticationStates {}

class CreateUserSuccessState extends AuthenticationStates {
  final String uId;

  CreateUserSuccessState(this.uId);
}

class CreateUserErrorState extends AuthenticationStates {
  final String error;

  CreateUserErrorState(this.error);
}

// all state signIn facebook
class SignInFacebookLoadingState extends AuthenticationStates {}

class SignInFacebookSuccessState extends AuthenticationStates {}

class SignInFacebookErrorState extends AuthenticationStates {
  final String error;

  SignInFacebookErrorState(this.error);
}

// all state signIn google
class SignInGoogleLoadingState extends AuthenticationStates {}

class SignInGoogleSuccessState extends AuthenticationStates {}

class SignInGoogleErrorState extends AuthenticationStates {
  final String error;

  SignInGoogleErrorState(this.error);
}


// all states LogIn
class LoginInitialState extends AuthenticationStates {}

class LoginLoadingState extends AuthenticationStates {}

class LoginSuccessState extends AuthenticationStates {
  final String uId;

  LoginSuccessState(this.uId);
}

class LoginErrorState extends AuthenticationStates {
  final String error;

  LoginErrorState(this.error);
}
