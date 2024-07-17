import 'package:final_project/bloc/Favs/favs_bloc.dart';
import 'package:final_project/bloc/Search/search_bloc.dart';
import 'package:final_project/bloc/Suggestor/suggestor_bloc.dart';

import '../Home/home_bloc.dart';

abstract class ProfileEvent{}

class LoadProfileEvent extends ProfileEvent{}

class LogoutButtonPressed extends ProfileEvent{

  final HomeBloc homeBloc;
  final SearchBloc searchBloc;
  final FavBloc favBloc;
  final SuggestorBloc suggestorBloc;

  LogoutButtonPressed({required this.homeBloc, required this.searchBloc, required this.favBloc, required this.suggestorBloc});

}