import 'package:final_project/Model/book.dart';
import 'package:final_project/bloc/Favs/favs_bloc.dart';
import 'package:final_project/bloc/Favs/favs_event.dart';
import 'package:final_project/bloc/Favs/favs_state.dart';
import 'package:final_project/screens/details_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../mock.dart';

//class MockFavBloc extends Mock implements FavBloc {}

Future<void> main() async {

  setupFirebaseAuthMocks();
  await Firebase.initializeApp();


  //late MockFavBloc mockFavBloc;
  late FavBloc favBloc;

  setUp(() {
    favBloc = FavBloc();
  });

    Future<void> pumpDetailsScreen(WidgetTester tester, Book book) async {
      await mockNetworkImagesFor((() =>  tester.pumpWidget(
        MaterialApp(
          home: DetailsPage(book: book, favsBloc: favBloc),
        )
      )
      ));
      //await tester.pumpAndSettle();
    }

  testWidgets('DetailsPage UI Test', (WidgetTester tester) async {
    final book = Book(
      bookId: '1',
      name: 'Book Name',
      cover: 'https://example.com/cover.jpg',
      url: 'https://example.com/book',
    );

    //final FavsState favState = FavIconState(flag: true);
    //when(mockFavBloc.state).thenReturn(favState);

    /*await tester.pumpWidget(
      MaterialApp(
        home: DetailsPage(
          book: book,
          favsBloc: mockFavBloc,
        ),
      ),
    );*/

    await pumpDetailsScreen(tester, book);

    await tester.pumpAndSettle();

    // Verify the presence of specific widgets
    expect(find.text('Details'), findsOneWidget);
    //expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    //expect(find.byIcon(Icons.favorite), findsOneWidget);
    //expect(find.byType(Image), findsOneWidget);
    //expect(find.text('Book Name'), findsOneWidget);
    //expect(find.text('Sample Description'), findsOneWidget);
    //expect(find.text('Visit this book\'s Goodreads profile'), findsOneWidget);

    // Verify the state of the favorite button
    //final favoriteButton = find.byIcon(Icons.favorite).evaluate().first.widget as IconButton;
    //expect(favoriteButton.color, Colors.red);
    
    // Perform a tap on the favorite button
    //await tester.tap(favoriteButton as Finder);
    //await tester.pumpAndSettle();

    // Verify the updated state of the favorite button
    //final updatedFavoriteButton = find.byIcon(Icons.favorite_border).evaluate().first.widget as IconButton;
    //expect(updatedFavoriteButton.color, null);

    // Verify that the appropriate events were called on the FavBloc
    //verify(mockFavBloc.add(AddToFavs(book: book))).called(1);
    //verify(mockFavBloc.add(RemoveFromFavs(book: book))).called(1);
  });
}