import 'package:final_project/Model/book.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState{}

class HomeLoadingState extends HomeState{}

class HomeLoadingSuccess extends HomeState{
  final List<Book> list;

  HomeLoadingSuccess({required this.list});
}

class HomeLoadingFailure extends HomeState {
  final String errorMessage;

  HomeLoadingFailure({required this.errorMessage});

}