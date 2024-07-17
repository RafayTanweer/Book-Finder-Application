
import 'package:final_project/bloc/Favs/favs_bloc.dart';
import 'package:final_project/bloc/Profile/profile_event.dart';
import 'package:final_project/bloc/Search/search_bloc.dart';
import 'package:final_project/bloc/Suggestor/suggestor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Home/home_bloc.dart';
import '../bloc/Profile/profile_bloc.dart';
import '../bloc/Profile/profile_state.dart';
import 'login_screen.dart';


class ProfileScreen extends StatefulWidget {
  final ProfileBloc profileBloc;
  final HomeBloc homeBloc;
  final SearchBloc searchBloc;
  final FavBloc favBloc;
  final SuggestorBloc suggestorBloc;

  const ProfileScreen({super.key, required this.profileBloc, required this.homeBloc, required this.searchBloc, required this.favBloc, required this.suggestorBloc});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
    widget.profileBloc.add(LoadProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        bloc: widget.profileBloc,
        listener: (context, state) {
          if(state is LogoutSuccessState){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
          }
        },
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileSuccessState) {
            final userData = state.userData;
            String avatarUrl = '';
      
            if (userData['gender'] == "Male") {
              avatarUrl = 'https://static.vecteezy.com/system/resources/previews/002/002/427/original/man-avatar-character-isolated-icon-free-vector.jpg';
            } else if (userData['gender'] == "Female") {
              avatarUrl = 'https://media.istockphoto.com/id/1331335536/vector/female-avatar-icon.jpg?s=170667a&w=0&k=20&c=-iyD_53ZEeZPc4SmvmGB1FJXZcHy_fvbJBv6O8HblHs=';
            }
      
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(avatarUrl),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    userData['name'],
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Gender: ${userData['gender']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Email: ${userData['email']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Logged Out"),
                        ),
                      );
                      widget.profileBloc.add(
                      LogoutButtonPressed(homeBloc: widget.homeBloc, searchBloc: widget.searchBloc, favBloc: widget.favBloc, suggestorBloc: widget.suggestorBloc)
                      );
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}