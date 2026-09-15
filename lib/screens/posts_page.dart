import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/api/bloc/posts_bloc.dart';
import 'package:untitled/widgets/error_wid.dart';
import 'package:untitled/widgets/loaded_widget.dart';
import 'package:untitled/widgets/loading_widget.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final currentScroll = _scrollController.offset;
    final maxScroll = _scrollController.position.maxScrollExtent;
    if (currentScroll >= maxScroll) {
      context.read<PostsBloc>().add(GetPostsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Posts'),
          centerTitle: true,
        ),
        body: (state.status == PostsStatus.loading)
            ? LoadingWidget()
            : state.status == PostsStatus.loaded
                ? ListView.builder(
                    controller: _scrollController,
                    itemCount: state.hasReachedMax
                        ? state.posts.length
                        : state.posts.length + 1,
                    itemBuilder: (context, index) {
                      return (index >= state.posts.length)
                          ? LoadingWidget()
                          : LoadedWidget(
                              post: state.posts[index],
                            );
                    })
                : ErrorWid(message: state.errorMessage),
      );
    });
  }
}
