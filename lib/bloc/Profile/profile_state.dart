abstract class ProfileState{}

class ProfileInitialState extends ProfileState{}

class ProfileLoadingState extends ProfileState{}

class ProfileSuccessState extends ProfileState{

  Map<String, dynamic> userData;

  ProfileSuccessState({required this.userData});


}

class ProfileFailureState extends ProfileState{

  final String errorMessage;

  ProfileFailureState({required this.errorMessage});

}

class LogoutSuccessState extends ProfileState{}