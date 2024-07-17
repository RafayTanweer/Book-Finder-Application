
import 'package:final_project/bloc/Favs/favs_bloc.dart';
import 'package:final_project/bloc/Home/home_bloc.dart';
import 'package:final_project/bloc/Profile/profile_bloc.dart';
import 'package:final_project/bloc/Search/search_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/Auth/authentication_bloc.dart';
import '../bloc/Auth/authentication_event.dart';
import '../bloc/Auth/authentication_state.dart';
import '../bloc/Suggestor/suggestor_bloc.dart';
import '../screens/favorites_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';
import '../screens/suggestor_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final homeBloc = HomeBloc();
  final searchBloc = SearchBloc();
  final favsBloc = FavBloc();
  final suggestorBloc = SuggestorBloc();
  final profileBloc = ProfileBloc();
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final int currentIndex = state is AuthenticationSuccess ? state.index : 0;

        return Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: [
              HomeScreen(homeBloc: homeBloc, favsBloc: favsBloc),
              SearchScreen(searchBloc: searchBloc, favsBloc: favsBloc),
              FavoritesScreen(favsBloc: favsBloc),
              SuggestorScreen(suggestorBloc: suggestorBloc, favsBloc: favsBloc),
              ProfileScreen(profileBloc: profileBloc, homeBloc: homeBloc, searchBloc: searchBloc, favBloc: favsBloc, suggestorBloc: suggestorBloc)
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (int index) {
              /*if (index == 2) {
                favsBloc.add(GetFavs());
              }*/
              context.read<AuthenticationBloc>().add(UpdateNavigationIndex(index: index));
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.electric_bolt),
                label: 'Suggestor',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}