import 'dart:convert';

import 'package:untitled/models/post.dart';
import 'package:http/http.dart' as http;

class PostsApi {
  Future<List<Post>> getAllPosts([int startIndex = 0, int limit = 20]) async {
    try {
      http.Response response = await http.get(Uri.parse(
          'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit'));
      List<Post> posts = (json
          .decode(response.body)
          .map<Post>((json) => Post.fromJson(json))).toList();
      return posts;
    } catch (e) {
      rethrow;
    }
  }
}
