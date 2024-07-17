
import 'package:final_project/bloc/Auth/authentication_bloc.dart';
import '../mock.dart';
import 'package:final_project/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {

  setupFirebaseAuthMocks();
  await Firebase.initializeApp();

  group('SignupScreen', () {
    //final authenticationBloc = MockBloc<AuthenticationEvent, AuthenticationState>();

    final authBloc = AuthenticationBloc();

    Future<void> pumpSignupScreen(WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => authBloc,
          child: MaterialApp(
            home: SignupScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('renders correctly', (WidgetTester tester) async {

      await pumpSignupScreen(tester);

      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Age'), findsOneWidget);
      expect(find.text('Gender'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Signup'), findsWidgets);
      expect(find.text('Already have an account ? Login'), findsOneWidget);
    });

    tearDown(() {
      authBloc.close();
    });

  });

}