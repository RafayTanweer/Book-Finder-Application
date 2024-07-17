
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {

  final int index;

  AuthenticationSuccess({required this.index});

}

class AuthenticationFailure extends AuthenticationState {
  final String errorMessage;

  AuthenticationFailure({required this.errorMessage});

}

//class LogoutSuccessState extends AuthenticationState{}