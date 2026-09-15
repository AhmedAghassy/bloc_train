import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/api/bloc/posts_bloc.dart';

class ErrorWid extends StatelessWidget {
  final String message;

  const ErrorWid({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Text(
              message,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<PostsBloc>().add(GetPostsEvent(fromTryButton: true));
            },
            child: Text('Try again'),
          ),
        ],
      ),
    );
  }
}
