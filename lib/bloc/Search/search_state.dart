import 'package:final_project/Model/book.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState{}

class SearchLoadingState extends SearchState{}

class SearchLoadingSuccess extends SearchState{
  final List<Book> list;

  SearchLoadingSuccess({required this.list});
}

class SearchLoadingFailure extends SearchState {
  final String errorMessage;

  SearchLoadingFailure({required this.errorMessage});

}