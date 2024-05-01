import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/ui/pages/add_blog.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () =>Navigator.push(context, AddBlog.route()), icon: const Icon(CupertinoIcons.add_circled))
        ],
      ),
    );
  }
}
