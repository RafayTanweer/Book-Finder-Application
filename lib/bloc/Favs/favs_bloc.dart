import 'dart:developer';

import 'package:final_project/bloc/Favs/favs_event.dart';
import 'package:final_project/bloc/Favs/favs_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Model/book.dart';

class FavBloc extends Bloc<FavsEvent, FavsState>{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FavBloc() : super(FavInitialState()){

    on<CheckFavEvent>(((event, emit) async {

      emit(FavLoadingState());

      bool flag = false;

      final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
      await _firestore.collection('users').doc(_firebaseAuth.currentUser!.uid).get();

      if (!userSnapshot.exists || !userSnapshot.data()!.containsKey('favorites')) {
        emit(FavIconState(flag: false));
      }
      else{

        final List<dynamic>? favorites = userSnapshot.data()!['favorites'];

        if (favorites!.isEmpty) {
          emit(FavIconState(flag: false));
        }
        else{

          for (dynamic item in favorites) {
            if (item is Map<String, dynamic> && item['book_id'] == event.book.bookId) {
              flag = true;
              break;
            }
          }

          if(flag){
            emit(FavIconState(flag: true));
            log("print");
          }else{
            emit(FavIconState(flag: false));
          }

        }

      }
      
    }));

    on<AddToFavs>((event, emit) async {

      emit(FavIconState(flag: true));

      final userRef = _firestore.collection('users').doc(_firebaseAuth.currentUser!.uid);

      await userRef.set(
        {
          'favorites': FieldValue.arrayUnion([event.book.toJson()]),
        },
        SetOptions(merge: true),
      );
      
    });

    on<RemoveFromFavs>(((event, emit) async{

      emit(FavIconState(flag: false));

      await _firestore
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid) // Replace userId with the user's document ID
        .update({
          'favorites': FieldValue.arrayRemove([event.book.toJson()]) // Assuming book.toMap() returns the book object as a Map
        });
      
    }));

    on<GetFavs>(((event, emit) async {

      emit(FavLoadingState());

      List<Book> list = [];

      final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await _firestore.collection('users').doc(_firebaseAuth.currentUser!.uid).get();

      if (!userSnapshot.exists || !userSnapshot.data()!.containsKey('favorites')) {
        emit(FavFailureState(errorMessage: "You have no favorites"));
      }
      else{

        final List<dynamic>? favorites = userSnapshot.data()!['favorites'];

        if (favorites!.isEmpty) {
          emit(FavFailureState(errorMessage: "You have no favorites"));
        }
        else{

          for(dynamic item in favorites){

            list.add(Book.fromJson(item));

          }

          emit(FavSuccessState(list: list));


        }

      }
      
    }));

  }


}