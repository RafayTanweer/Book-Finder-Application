abstract class SearchEvent {}

class LoadSearchQueryBooksEvent extends SearchEvent {
  String bookName;

  LoadSearchQueryBooksEvent({required this.bookName});
}