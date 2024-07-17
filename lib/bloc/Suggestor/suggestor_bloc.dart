import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/bloc/Suggestor/suggestor_event.dart';
import 'package:final_project/bloc/Suggestor/suggestor_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/book.dart';

class SuggestorBloc extends Bloc<SuggestorEvent, SuggestorState>{

  List<String> genres = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SuggestorBloc() : super(SuggestorInitialState()){

    on<LoadSuggestionsEvent>(((event, emit) async{
      
      emit(SuggestorLoadingState());

      if(genres.isEmpty){
        emit(SuggestorFailureState(errorMessage: "No Genres Selected"));
      }
      else{

        List<Book> list = [];

        if(genres.contains('Horror')){

          QuerySnapshot querySnapshot = await _firestore.collection('horrorCollection').get();

          querySnapshot.docs.forEach((doc) {
            Book book = Book.fromJson(doc.data() as Map<String, dynamic>);
            list.add(book);
          });

        }
        if(genres.contains('Adventure')){

          QuerySnapshot querySnapshot = await _firestore.collection('adventureCollection').get();

          querySnapshot.docs.forEach((doc) {
            Book book = Book.fromJson(doc.data() as Map<String, dynamic>);
            list.add(book);
          });

        }
        if(genres.contains('Mystery')){

          QuerySnapshot querySnapshot = await _firestore.collection('mysteryCollection').get();

          querySnapshot.docs.forEach((doc) {
            Book book = Book.fromJson(doc.data() as Map<String, dynamic>);
            list.add(book);
          });

        }
        if(genres.contains('Romance')){

          QuerySnapshot querySnapshot = await _firestore.collection('romanceCollection').get();

          querySnapshot.docs.forEach((doc) {
            Book book = Book.fromJson(doc.data() as Map<String, dynamic>);
            list.add(book);
          });

        }

        

        emit(SuggestorSuccessState(list: list));

      }

    }));

    on<AddGenreEvent>(((event, emit) {
      genres.add(event.genre);
      emit(AddGenreSuccessState());
    }));

    on<RemoveGenreEvent>(((event, emit) {
      genres.remove(event.genre);
      emit(RemoveGenreSuccessState());
    }));



  }

  List<String> selectedGenres(){
    return genres;
  }



}