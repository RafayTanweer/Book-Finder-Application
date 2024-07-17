abstract class SuggestorEvent{}

class LoadSuggestionsEvent extends SuggestorEvent{

  LoadSuggestionsEvent();

}

class AddGenreEvent extends SuggestorEvent{

  final String genre;

  AddGenreEvent({required this.genre});

}

class RemoveGenreEvent extends SuggestorEvent{

  final String genre;

  RemoveGenreEvent({required this.genre});


}