import 'package:final_project/navbar/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/Auth/authentication_bloc.dart';
import '../bloc/Auth/authentication_event.dart';
import '../bloc/Auth/authentication_state.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late String genderValue = "Male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(

        listener: (context, state) {
          if (state is AuthenticationFailure) {
            // Show error message to the user
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
          } else if (state is AuthenticationSuccess) {

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
            
          }
        },

        builder: (context, state) {

          return SingleChildScrollView(
            child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  value: 'Male',
                  onChanged: (newValue) {
                    genderValue = newValue!;
                  },
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'Male',
                      child: Text('Male'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Female',
                      child: Text('Female'),
                    ),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Age',
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                        SignupButtonPressed(
                          name: _nameController.text,
                          gender: genderValue,
                          age: _ageController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      );
                    },
                    child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Visibility(
                              visible: state is! AuthenticationLoading,
                              child: const Text('Signup'),
                            ),
                            Visibility(
                              visible: state is AuthenticationLoading,
                              child: const CircularProgressIndicator(color: Colors.white),
                            ),
                          ],
                        ),
                  ),
                ),
          
                GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context, 
                          MaterialPageRoute(builder:(context) => LoginScreen())
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: const [
                            
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Colors.red
                              ),
                            ),
                            
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Already have an account ? Login', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                            ),
                            
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Colors.red
                              ),
                            )
                            
                          ],
                          
                        ),
                      ),
                    ),
              ],
            ),
            ),
          );

        }
        
      ),
    );
  }
}