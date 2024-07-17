import '../../Model/book.dart';

abstract class FavsState {}

class FavInitialState extends FavsState{}

class FavLoadingState extends FavsState{}

class FavIconState extends FavsState{

  final bool flag;

  FavIconState({required this.flag});

}

class FavSuccessState extends FavsState{

  final List<Book> list;

  FavSuccessState({required this.list});

}

class FavFailureState extends FavsState{

  final String errorMessage;

  FavFailureState({required this.errorMessage});

}