import 'package:bloc_test/bloc_test.dart';
import 'package:final_project/bloc/Auth/authentication_bloc.dart';
import 'package:final_project/bloc/Auth/authentication_event.dart';
import 'package:final_project/bloc/Auth/authentication_state.dart';
import 'package:final_project/navbar/main_screen.dart';
import 'package:final_project/screens/login_screen.dart';
import 'package:final_project/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock.dart';


Future<void> main() async {

  setupFirebaseAuthMocks();
  await Firebase.initializeApp();

  group('LoginScreen', () {
    //final authenticationBloc = MockBloc<AuthenticationEvent, AuthenticationState>();

    final authBloc = AuthenticationBloc();

    Future<void> pumpLoginScreen(WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => authBloc,
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('renders correctly', (WidgetTester tester) async {
      // Pump the LoginScreen widget
      await pumpLoginScreen(tester);

      // Verify that the widgets are rendered correctly
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Login'), findsWidgets);
      expect(find.text('Sign Up here!'), findsOneWidget);
    });

    /*testWidgets('shows error message on authentication failure',
        (WidgetTester tester) async {
      // Stub the authenticationBloc's state to emit an AuthenticationFailure
      whenListen(
        authenticationBloc,
        Stream.fromIterable([
          AuthenticationFailure(errorMessage: 'Invalid credentials'),
        ]),
      );

      // Pump the LoginScreen widget
      await pumpLoginScreen(tester);

      // Verify that the error message is displayed
      expect(find.text('Invalid credentials'), findsOneWidget);
    });

    testWidgets('navigates to MainScreen on authentication success',
        (WidgetTester tester) async {
      // Stub the authenticationBloc's state to emit an AuthenticationSuccess
      whenListen(
        authenticationBloc,
        Stream.fromIterable([
          AuthenticationSuccess(index: 0),
        ]),
      );

      // Pump the LoginScreen widget
      await pumpLoginScreen(tester);

      // Verify that the MainScreen is navigated to
      expect(find.byType(MainScreen), findsOneWidget);
    });

    testWidgets('navigates to SignupScreen on "Sign Up here!" tap',
        (WidgetTester tester) async {
      // Pump the LoginScreen widget
      await pumpLoginScreen(tester);

      // Tap on the "Sign Up here!" text
      await tester.tap(find.text('Sign Up here!'));
      await tester.pumpAndSettle();

      // Verify that the SignupScreen is navigated to
      expect(find.byType(SignupScreen), findsOneWidget);
    });*/

    // Add more test cases as needed

    tearDown(() {
      authBloc.close();
    });
  });
}