
import 'package:final_project/bloc/Favs/favs_bloc.dart';
import 'package:final_project/bloc/Suggestor/suggestor_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Suggestor/suggestor_bloc.dart';
import '../bloc/Suggestor/suggestor_state.dart';
import 'details_screen.dart';

class SuggestorScreen extends StatelessWidget {
  final SuggestorBloc suggestorBloc;
  final FavBloc favsBloc;

  const SuggestorScreen({super.key, required this.suggestorBloc, required this.favsBloc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suggestor'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: buildGenreBox(),
          ),
          Expanded(
            child: BlocBuilder<SuggestorBloc, SuggestorState>(
              bloc: suggestorBloc,
              builder: (context, state) {
                if (state is SuggestorLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SuggestorSuccessState) {
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
                              // Handle item click if needed
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is SuggestorFailureState) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                } else {
                  return Container(); // Handle other states if needed
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showGenreSelectionPopup(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildGenreBox() {

  var selectedGenres = suggestorBloc.selectedGenres();
  
  return BlocConsumer<SuggestorBloc, SuggestorState>(
    bloc: suggestorBloc,
    listener: (context, state) {
      if(state is AddGenreSuccessState){
        selectedGenres = suggestorBloc.selectedGenres();
      }
    },
    builder: (context, state) {
      //final selectedGenres = widget.suggestorBloc.selectedGenres();

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selected Genres:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: selectedGenres.map((genre) {
                return Chip(
                  label: Text(genre.toString()),
                  onDeleted: () {
                    suggestorBloc.add(RemoveGenreEvent(genre: genre));
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  suggestorBloc.add(LoadSuggestionsEvent());
                },
                child: const Text('Suggest'),
              ),
            ),
          ],
        ),
      );
    },
  );
}

  void showGenreSelectionPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return BlocListener<SuggestorBloc, SuggestorState>(
        bloc: suggestorBloc,
        listener: (context, state) {
          if (state is AddGenreSuccessState) {
            Navigator.pop(context); // Close the dialog after genre is added
          }
        },
        child: AlertDialog(
          title: const Text('Select Genre'),
          content: BlocBuilder<SuggestorBloc, SuggestorState>(
            bloc: suggestorBloc,
            builder: (context, state) {
              final selectedGenres = suggestorBloc.selectedGenres();
              final availableGenres = [
                'Horror',
                'Adventure',
                'Mystery',
                'Romance',
              ].where((genre) => !selectedGenres.contains(genre)).toList();

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: availableGenres.map((genre) {
                  return ListTile(
                    title: Text(genre.toString()),
                    onTap: () {
                      suggestorBloc.add(AddGenreEvent(genre: genre));
                    },
                  );
                }).toList(),
              );
            },
          ),
        ),
      );
    },
  );
}
}
