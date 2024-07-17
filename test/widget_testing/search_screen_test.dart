import 'package:final_project/bloc/Favs/favs_bloc.dart';
import 'package:final_project/bloc/Search/search_bloc.dart';
import '../mock.dart';
import 'package:final_project/screens/search_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {

  setupFirebaseAuthMocks();
  await Firebase.initializeApp();

  late SearchBloc searchBloc;
  late FavBloc favBloc;

  setUp(() {
    searchBloc = SearchBloc();
    favBloc = FavBloc();
  });

  Future<void> pumpSearchScreen(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SearchScreen(searchBloc: searchBloc, favsBloc: favBloc,),
        )
      );
      //await tester.pumpAndSettle();
    }

  testWidgets('SearchScreen renders correctly', (WidgetTester tester) async {

    await pumpSearchScreen(tester);

    expect(find.text('Search'), findsWidgets);
    expect(find.byType(SearchBar), findsOneWidget);

  });

  tearDown(() {
    searchBloc.close();
    favBloc.close();
  });

}