abstract class HomeEvent {}

class LoadPopularBooksEvent extends HomeEvent {}

class LoadNominatedBooksEvent extends HomeEvent {}

class LoadAwardedBooksEvent extends HomeEvent {}

/*class LoadSearchQueryBooksEvent extends HomeEvent {
  String bookName;

  LoadSearchQueryBooksEvent({required this.bookName});
}*/