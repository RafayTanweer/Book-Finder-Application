import 'package:final_project/bloc/Favs/favs_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Model/book.dart';
import '../bloc/Home/home_bloc.dart';
import '../bloc/Home/home_event.dart';
import '../bloc/Home/home_state.dart';
import 'details_screen.dart';


class HomeScreen extends StatefulWidget {
  final HomeBloc homeBloc;
  final FavBloc favsBloc;

  const HomeScreen({Key? key, required this.homeBloc, required this.favsBloc})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late HomeBloc _popularBooksBloc;
  late HomeBloc _awardedBooksBloc;
  late HomeBloc _nominatedBooksBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _popularBooksBloc = HomeBloc();
    _awardedBooksBloc = HomeBloc();
    _nominatedBooksBloc = HomeBloc();
    _popularBooksBloc.add(LoadPopularBooksEvent());
  }

  @override
  void dispose() {
    _tabController.dispose();
    _popularBooksBloc.close();
    _awardedBooksBloc.close();
    _nominatedBooksBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.blue.withOpacity(0.3),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: const [
              Tab(text: 'Popular'),
              Tab(text: 'Awarded'),
              Tab(text: 'Nominated'),
            ],
            onTap: (index) {
              if (index == 0) {
                _popularBooksBloc.add(LoadPopularBooksEvent());
              } else if (index == 1) {
                _awardedBooksBloc.add(LoadAwardedBooksEvent());
              } else if (index == 2) {
                _nominatedBooksBloc.add(LoadNominatedBooksEvent());
              }
            },
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                BlocBuilder<HomeBloc, HomeState>(
                  bloc: _popularBooksBloc,
                  builder: (context, state) {
                    if (state is HomeLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is HomeLoadingSuccess) {
                      return Panel(
                        books: state.list,
                        favsBloc: widget.favsBloc,
                      );
                    } else if (state is HomeLoadingFailure) {
                      return Center(
                        child: Text('Error: ${state.errorMessage}'),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  bloc: _awardedBooksBloc,
                  builder: (context, state) {
                    if (state is HomeLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is HomeLoadingSuccess) {
                      return Panel(
                        books: state.list,
                        favsBloc: widget.favsBloc,
                      );
                    } else if (state is HomeLoadingFailure) {
                      return Center(
                        child: Text('Error: ${state.errorMessage}'),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  bloc: _nominatedBooksBloc,
                  builder: (context, state) {
                    if (state is HomeLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is HomeLoadingSuccess) {
                      return Panel(
                        books: state.list,
                        favsBloc: widget.favsBloc,
                      );
                    } else if (state is HomeLoadingFailure) {
                      return Center(
                        child: Text('Error: ${state.errorMessage}'),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Panel extends StatelessWidget {
  final List<Book> books;
  final FavBloc favsBloc;

  const Panel({Key? key, required this.books, required this.favsBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailsPage(book: book, favsBloc: favsBloc),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: NetworkImage(book.cover!), fit: BoxFit.cover)),
              margin: const EdgeInsets.all(8.0),
            ),
          );
        },
      ),
    );
  }
}
