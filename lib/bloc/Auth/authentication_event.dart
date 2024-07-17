import '../Home/home_bloc.dart';

abstract class AuthenticationEvent {}

class LoginButtonPressed extends AuthenticationEvent {
  final String email;
  final String password;

  LoginButtonPressed({required this.email, required this.password});

}

class SignupButtonPressed extends AuthenticationEvent {
  final String name;
  final String gender;
  final String age;
  final String email;
  final String password;

  SignupButtonPressed({
    required this.name,
    required this.gender,
    required this.age,
    required this.email,
    required this.password,
  });

}

class UpdateNavigationIndex extends AuthenticationEvent{

  final int index;

  UpdateNavigationIndex({required this.index});

}

/*class LogoutButtonPressed extends AuthenticationEvent {

  final HomeBloc homeBloc;

  LogoutButtonPressed({required this.homeBloc});

}*/