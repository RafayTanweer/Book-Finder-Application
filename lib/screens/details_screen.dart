import 'package:final_project/bloc/Favs/favs_bloc.dart';
import 'package:final_project/bloc/Favs/favs_event.dart';
import 'package:final_project/bloc/Favs/favs_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Model/book.dart';



class DetailsPage extends StatefulWidget {

  final Book book;
  final FavBloc favsBloc;

  const DetailsPage({super.key, required this.book, required this.favsBloc});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
  
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
    widget.favsBloc.add(CheckFavEvent(book: widget.book));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavBloc, FavsState>(
      bloc: widget.favsBloc,
      builder: (context, state){
        bool isFavorite = state is FavIconState ? state.flag : false;
        return Scaffold(
        appBar: AppBar(
          title: const Text('Details'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              widget.favsBloc.add(GetFavs());
              Navigator.pop(context);
            },
          ),
          actions: [
            if (state is FavLoadingState)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              )
            else
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  if (isFavorite) {
                    widget.favsBloc.add(RemoveFromFavs(book: widget.book));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Removed From Favorites"),
                      ),
                    );
                  } else {
                    widget.favsBloc.add(AddToFavs(book: widget.book));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Added to Favorites"),
                      ),
                    );
                  }
                },
              ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Image.network(widget.book.cover!),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.book.name!,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "In a thrilling tale of love and betrayal, a detective races against time to uncover the truth behind a series of mysterious murders in a small coastal town.",
                    style: TextStyle(fontSize: 16, ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    launchUrl(Uri.parse(widget.book.url!));
                  },
                  child: const Text('Visit this book\'s Goodreads profile'),
                ),
              ],
            ),
          ),
        ),
        );
      

      
      } 

    );
  

  }
  
}