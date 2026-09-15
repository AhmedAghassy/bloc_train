part of 'posts_bloc.dart';

enum PostsStatus {
  loading,
  loaded,
  error,
}

class PostsState {
  final PostsStatus status;
  final List<dynamic> posts;
  final String errorMessage;
  final bool hasReachedMax;

  const PostsState({
    this.status = PostsStatus.loading,
    this.posts = const [],
    this.errorMessage = '',
    this.hasReachedMax = false,
  });

  PostsState copyWith({
    PostsStatus? status,
    List<dynamic>? posts,
    String? errorMessage,
    bool? hasReachedMax,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
