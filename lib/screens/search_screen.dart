import 'package:final_project/bloc/Favs/favs_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Search/search_bloc.dart';
import '../bloc/Search/search_event.dart';
import '../bloc/Search/search_state.dart';
import 'details_screen.dart';

class SearchScreen extends StatelessWidget {
  final SearchBloc searchBloc;
  final FavBloc favsBloc;
  final TextEditingController searchController = TextEditingController();

  SearchScreen({super.key, required this.searchBloc, required this.favsBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: SearchBar(
              onSearch: (String query) {
                searchBloc.add(LoadSearchQueryBooksEvent(bookName: query));
              },
              controller: searchController,
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              bloc: searchBloc,
              builder: (context, state) {
                if (state is SearchLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchLoadingSuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView.builder(
                      itemCount: state.list.length,
                      itemBuilder: (context, index) {
                        final book = state.list[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(book: book, favsBloc: favsBloc)));
                          },
                          child: Card(
                            elevation: 1.5,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            color: Color.fromARGB(255, 244, 244, 244),
                            shadowColor: Colors.black,
                            child: ListTile(
                              visualDensity: VisualDensity.comfortable,
                              leading: Image.network(
                                book.cover!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              title: Text(book.name!),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is SearchLoadingFailure) {
                  return Center(
                    child: Text('Error: ${state.errorMessage}'),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final Function(String) onSearch;
  final TextEditingController controller;

  SearchBar({required this.onSearch, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: 'Search',
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            controller.clear();
          },
        ),
      ),
      onSubmitted: (value) {
        onSearch(value);
      },
    );
  }
}