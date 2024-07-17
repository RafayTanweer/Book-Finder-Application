import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/bloc/Profile/profile_event.dart';
import 'package:final_project/bloc/Profile/profile_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProfileBloc() : super(ProfileInitialState()){

    on<LoadProfileEvent>(((event, emit) async {
      
      emit(ProfileLoadingState());

      DocumentSnapshot userDoc = await _firestore
      .collection('users')
      .doc(_firebaseAuth.currentUser!.uid)
      .get();

      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      emit(ProfileSuccessState(userData: userData));

    }));

    on<LogoutButtonPressed>(((event, emit) async {

      event.homeBloc.close();
      event.searchBloc.close();
      event.favBloc.close();
      event.suggestorBloc.close();

      await _firebaseAuth.signOut();
      emit(LogoutSuccessState());

      close();

    }));

  }

}