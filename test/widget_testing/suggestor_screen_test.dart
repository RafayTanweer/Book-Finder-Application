import 'package:final_project/bloc/Favs/favs_bloc.dart';
import 'package:final_project/bloc/Suggestor/suggestor_bloc.dart';
import '../mock.dart';
import 'package:final_project/screens/suggestor_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {

  setupFirebaseAuthMocks();
  await Firebase.initializeApp();

  late SuggestorBloc suggestorBloc;
  late FavBloc favBloc;

  setUp(() {
    suggestorBloc = SuggestorBloc();
    favBloc = FavBloc();
  });

  Future<void> pumpSuggestorScreen(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SuggestorScreen(suggestorBloc: suggestorBloc, favsBloc: favBloc,),
        )
      );
      //await tester.pumpAndSettle();
    }

  testWidgets('SuggestorScreen renders correctly', (WidgetTester tester) async {

    await pumpSuggestorScreen(tester);

    expect(find.text('Suggestor'), findsWidgets);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);

  });

  tearDown(() {
    suggestorBloc.close();
    favBloc.close();
  });

}