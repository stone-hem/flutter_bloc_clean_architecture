import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_clean_architecture/core/utils/pick_image.dart';
import 'package:flutter_bloc_clean_architecture/features/blog/ui/widgets/blog_input.dart';

class AddBlog extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const AddBlog());

  const AddBlog({super.key});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final selectedImage = await pickImage();
    if (selectedImage != null) {
      setState(() {
        image = selectedImage;
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(CupertinoIcons.check_mark))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                selectImage();
              },
              child: Card.outlined(
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: image == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(CupertinoIcons.folder_open),
                            Text(
                              'Select Your Image',
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                          ],
                        )
                      : Image.file(
                          image!,
                          fit: BoxFit.contain,
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  'Technology',
                  'Business',
                  'Programming',
                  'Entertainment'
                ]
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: InkWell(
                            onTap: () => setState(() {
                              if (selectedTopics.contains(e)) {
                                selectedTopics.remove(e);
                              } else {
                                selectedTopics.add(e);
                              }
                              print(selectedTopics);
                            }),
                            child: Chip(
                              backgroundColor: selectedTopics.contains(e)
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.transparent,
                              side: BorderSide(
                                  width: selectedTopics.contains(e) ? 0 : 1,
                                  color: Colors.grey),
                              labelStyle: TextStyle(
                                  color: selectedTopics.contains(e)
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                              label: Text(e),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlogInput(
              hintText: 'Title',
              controller: titleController,
              maxLines: 1,
            ),
            const SizedBox(
              height: 20,
            ),
            BlogInput(
              hintText: 'Content',
              controller: contentController,
              maxLines: 8,
            )
          ],
        ),
      ),
    );
  }
}
