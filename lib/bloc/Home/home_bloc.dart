import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/bloc/Home/home_event.dart';
import 'package:final_project/bloc/Home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import 'package:http/http.dart' as http;
//import 'dart:convert';

import '../../Model/book.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _popularFlag = false;
  bool _awardedFlag = false;
  bool _nominatedFlag = false;

  final List<Book> _popularBooks = [];
  final List<Book> _awardedBooks = [];
  final List<Book> _nominatedBooks = [];

  HomeBloc() : super(HomeInitialState()){


    on<LoadPopularBooksEvent>((event, emit) async {

      emit(HomeLoadingState());

      if(!_popularFlag){

      QuerySnapshot querySnapshot = await _firestore.collection('popularCollection').get();

      querySnapshot.docs.forEach((doc) {
        Book book = Book.fromJson(doc.data() as Map<String, dynamic>);
        _popularBooks.add(book);
      });

      _popularFlag = true;

      emit(HomeLoadingSuccess(list: _popularBooks));

      }
      else{
        emit(HomeLoadingSuccess(list: _popularBooks));
      }

      /*

      //Fetch From API

      final url = Uri.parse(
        'https://hapi-books.p.rapidapi.com/month/2022/3');

      var response = await http.get(
          url,
          headers: {
            "X-RapidAPI-Host": 'hapi-books.p.rapidapi.com',
            "X-RapidAPI-Key": 'b95ea51b30msh5a79432eb9f4579p1e1d95jsn9ff419980392'
          },
      );

      /*if(response.statusCode == 200){

      final jsonData = jsonDecode(response.body) as List<dynamic>;
      popularBooks = jsonData.map((bookData) => Book.fromJson(bookData)).toList();

      }*/

      if(response.statusCode == 200){

      var jsonData = json.decode(response.body);

      jsonData.forEach((bk) {
        popularBooks.add(Book.fromJson(bk));
      });

      emit(HomeLoadingSuccess(list: popularBooks));

      }
      else{
        emit(HomeLoadingFailure(errorMessage: "Failed To Fetch"));
      }*/
   
    });

    on<LoadAwardedBooksEvent>((event, emit) async {

      emit(HomeLoadingState());

      if(!_awardedFlag){

      QuerySnapshot querySnapshot = await _firestore.collection('awardedCollection').get();

      querySnapshot.docs.forEach((doc) {
        Book book = Book.fromJson(doc.data() as Map<String, dynamic>);
        _awardedBooks.add(book);
      });

      _awardedFlag = true;

      emit(HomeLoadingSuccess(list: _awardedBooks));

      }
      else{
        emit(HomeLoadingSuccess(list: _awardedBooks));
      }

      /*

      //Fetch From API

      final url = Uri.parse(
        'https://hapi-books.p.rapidapi.com/top/2021');

      var response = await http.get(
          url,
          headers: {
            "X-RapidAPI-Host": 'hapi-books.p.rapidapi.com',
            "X-RapidAPI-Key": 'b95ea51b30msh5a79432eb9f4579p1e1d95jsn9ff419980392'
          },
      );

      /*if(response.statusCode == 200){

      final jsonData = jsonDecode(response.body) as List<dynamic>;
      popularBooks = jsonData.map((bookData) => Book.fromJson(bookData)).toList();

      }*/

      if(response.statusCode == 200){

      var jsonData = json.decode(response.body);

      jsonData.forEach((bk) {
        awardedBooks.add(Book.fromJson(bk));
      });

      emit(HomeLoadingSuccess(list: awardedBooks));

      }
      else{

        emit(HomeLoadingFailure(errorMessage: "Failed To Fetch"));

      }*/

    });

    on<LoadNominatedBooksEvent>((event, emit) async {

      emit(HomeLoadingState());

      if(!_nominatedFlag){

      QuerySnapshot querySnapshot = await _firestore.collection('nominatedCollection').get();

      querySnapshot.docs.forEach((doc) {
        Book book = Book.fromJson(doc.data() as Map<String, dynamic>);
        _nominatedBooks.add(book);
      });

      _nominatedFlag = true;

      emit(HomeLoadingSuccess(list: _nominatedBooks));

      }
      else{
        emit(HomeLoadingSuccess(list: _nominatedBooks));
      }

      /*

      //Fetch From API

      final url = Uri.parse(
        'https://hapi-books.p.rapidapi.com/nominees/romance/2020');

      var response = await http.get(
          url,
          headers: {
            "X-RapidAPI-Host": 'hapi-books.p.rapidapi.com',
            "X-RapidAPI-Key": 'b95ea51b30msh5a79432eb9f4579p1e1d95jsn9ff419980392'
          },
      );

      /*if(response.statusCode == 200){

      final jsonData = jsonDecode(response.body) as List<dynamic>;
      popularBooks = jsonData.map((bookData) => Book.fromJson(bookData)).toList();

      }*/

      if(response.statusCode == 200){

      var jsonData = json.decode(response.body);

      jsonData.forEach((bk) {
        nominatedBooks.add(Book.fromJson(bk));
      });

      emit(HomeLoadingSuccess(list: nominatedBooks));

      }
      else{

        emit(HomeLoadingFailure(errorMessage: "Failed To Fetch"));

      }*/
      
    });

  }

}
//await _firestore.collection('popularCollection').doc().set(popularBooks[popularBooks.length - 1].toJson());