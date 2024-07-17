import '../../Model/book.dart';

abstract class FavsEvent{}

class CheckFavEvent extends FavsEvent{

  final Book book;

  CheckFavEvent({required this.book});

}

class AddToFavs extends FavsEvent{

  final Book book;

  AddToFavs({required this.book});

}

class RemoveFromFavs extends FavsEvent{

  final Book book;

  RemoveFromFavs({required this.book});

}

class GetFavs extends FavsEvent{}