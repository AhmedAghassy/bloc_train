import 'package:flutter/material.dart';
import 'package:untitled/models/post.dart';

class LoadedWidget extends StatelessWidget {
  final Post post;

  const LoadedWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(post.id.toString()),
        ),
        title: Text(post.title),
        subtitle: Text(post.body),
        isThreeLine: true,
      ),
    );
  }
}
