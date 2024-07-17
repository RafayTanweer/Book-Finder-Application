import 'package:final_project/bloc/Search/search_event.dart';
import 'package:final_project/bloc/Search/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Model/book.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState>{

  SearchBloc() : super(SearchInitialState()){


    on<LoadSearchQueryBooksEvent>((event, emit) async {

      emit(SearchLoadingState());

      event.bookName = event.bookName.toLowerCase();
      event.bookName = event.bookName.trim();
      event.bookName = event.bookName.replaceAll(' ', '+');

      List<Book> searchedBooks = [];

      //Fetch From API

      final url = Uri.parse(
        'https://hapi-books.p.rapidapi.com/search/${event.bookName}');

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

      jsonData.forEach((bk){
        searchedBooks.add(Book.fromJson(bk));
      });

      if(searchedBooks.isEmpty){

        emit(SearchLoadingFailure(errorMessage: "No Books Found"));

      }
      else{

        emit(SearchLoadingSuccess(list: searchedBooks));

      }

      }
      else{

        emit(SearchLoadingFailure(errorMessage: "Failed To Fetch"));

      }
      
    });

  }

}