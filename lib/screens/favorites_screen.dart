
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Model/book.dart';
import '../bloc/Favs/favs_bloc.dart';
import '../bloc/Favs/favs_event.dart';
import '../bloc/Favs/favs_state.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  final FavBloc favsBloc;

  const FavoritesScreen({super.key, required this.favsBloc});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    widget.favsBloc.add(GetFavs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: BlocBuilder<FavBloc, FavsState>(
        bloc: widget.favsBloc,
        builder: (context, state) {
          if (state is FavLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavSuccessState) {
            return SingleChildScrollView(
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  Book book = state.list[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(
                              book: book, favsBloc: widget.favsBloc),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              image: NetworkImage(book.cover!),
                              fit: BoxFit.cover)),
                      margin: EdgeInsets.all(8.0),
                    ),
                  );
                },
              ),
            );
          } else if (state is FavFailureState) {
            return Center(child: Text(state.errorMessage));
          }
          return Container();
        },
      ),
    );
  }
}