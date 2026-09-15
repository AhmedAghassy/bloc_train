import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:untitled/api/posts_api.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(const PostsState()) {
    on<PostsEvent>(
      (event, emit) async {
        if (event is GetPostsEvent) {
          if (state.hasReachedMax) {
            return;
          }
          try {
            if (event.fromTryButton == true) {
              emit(PostsState());
            }
            if (state.status == PostsStatus.loading) {
              final posts = await PostsApi().getAllPosts();
              return posts.isEmpty
                  ? emit(state.copyWith(
                      status: PostsStatus.loaded, hasReachedMax: true))
                  : emit(
                      state.copyWith(
                        status: PostsStatus.loaded,
                        posts: posts,
                        hasReachedMax: false,
                      ),
                    );
            } else {
              final posts = await PostsApi().getAllPosts(state.posts.length);
              return posts.isEmpty
                  ? emit(
                      state.copyWith(
                        status: PostsStatus.loaded,
                        hasReachedMax: true,
                        posts: List.of(state.posts)..addAll(const []),
                      ),
                    )
                  : emit(
                      state.copyWith(
                        status: PostsStatus.loaded,
                        posts: List.of(state.posts)..addAll(posts),
                        hasReachedMax: false,
                      ),
                    );
            }
          } catch (e) {
            emit(
              state.copyWith(
                status: PostsStatus.error,
                errorMessage: 'Something went wrong, please try again later!',
              ),
            );
          }
        }
      },
      transformer: droppable(),
    );
  }
}
