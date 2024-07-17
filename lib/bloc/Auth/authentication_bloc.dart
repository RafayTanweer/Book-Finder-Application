import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthenticationBloc()
      :
        super(AuthenticationInitial()){

          on<LoginButtonPressed>((event, emit) async {
            if (event.email.isEmpty || event.password.isEmpty) {
              emit(AuthenticationFailure(errorMessage: "Please fill in the required fields"));
            } else {
              emit(AuthenticationLoading());
              try {
                await _firebaseAuth.signInWithEmailAndPassword(
                  email: event.email,
                  password: event.password,
                );
                emit(AuthenticationSuccess(index: 0));
              } catch (e) {
                emit(AuthenticationFailure(errorMessage: e.toString()));
              }
            }
          });

          on<SignupButtonPressed>((event, emit) async {

            if(event.name.isEmpty || event.gender.isEmpty || event.email.isEmpty || event.password.isEmpty || event.age.isEmpty){

              emit(AuthenticationFailure(errorMessage: "Please fill in the required fields"));

            }
            else if(int.parse(event.age) < 0){
              emit(AuthenticationFailure(errorMessage: "Age cannot be less than zero"));
            }
            else{

              emit(AuthenticationLoading());

              try {
                
                final UserCredential userCredential =
                    await _firebaseAuth.createUserWithEmailAndPassword(
                  email: event.email,
                  password: event.password,
                );

                final String uid = userCredential.user!.uid;

                await _firestore.collection('users').doc(uid).set({
                  'name': event.name,
                  'gender': event.gender,
                  'age': event.age,
                  'email': event.email,
                });

                 emit(AuthenticationSuccess(index: 0));
              } catch (e) {
                emit(AuthenticationFailure(errorMessage: e.toString()));
              }

            }

            
          });

          on<UpdateNavigationIndex>((event, emit) => {

            emit(AuthenticationSuccess(index: event.index))

          });

          /*on<LogoutButtonPressed>(((event, emit) async {

            event.homeBloc.close();

            await _firebaseAuth.signOut();
            emit(LogoutSuccessState());

          }));*/

        }
    }

