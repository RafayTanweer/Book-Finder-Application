import '../../Model/book.dart';

abstract class SuggestorState {}

class SuggestorInitialState extends SuggestorState{}

class SuggestorLoadingState extends SuggestorState{}

class SuggestorSuccessState extends SuggestorState{

  final List<Book> list;

  SuggestorSuccessState({required this.list});

}

class SuggestorFailureState extends SuggestorState{

  final String errorMessage;

  SuggestorFailureState({required this.errorMessage});


}

class AddGenreSuccessState extends SuggestorState{}

class RemoveGenreSuccessState extends SuggestorState{}