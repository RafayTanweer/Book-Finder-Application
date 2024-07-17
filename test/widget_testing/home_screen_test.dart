import 'package:final_project/bloc/Favs/favs_bloc.dart';
import 'package:final_project/bloc/Home/home_bloc.dart';
import 'package:final_project/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock.dart';

class MockHomeBloc extends Mock implements HomeBloc {}

class MockFavBloc extends Mock implements FavBloc {}

void main() async{

  setupFirebaseAuthMocks();
  await Firebase.initializeApp();

  late MockHomeBloc mockHomeBloc;
  late MockFavBloc mockFavBloc;

  setUp(() {
    mockHomeBloc = MockHomeBloc();
    mockFavBloc = MockFavBloc();
  });

  Future<void> pumpHomeScreen(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomeScreen(homeBloc: mockHomeBloc, favsBloc: mockFavBloc,),
        )
      );
      //await tester.pumpAndSettle();
    }

  testWidgets('HomeScreen UI renders correctly', (WidgetTester tester) async {

    await pumpHomeScreen(tester);

    expect(find.text('Home'), findsOneWidget);

    expect(find.byType(TabBar), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Awarded'), findsOneWidget);
    expect(find.text('Nominated'), findsOneWidget);

    expect(find.byType(TabBarView), findsOneWidget);

    //expect(find.byType(Panel), findsNWidgets(3));
  });

  /*tearDown(() {
    mockHomeBloc.close();
    mockFavBloc.close();
  });*/

}