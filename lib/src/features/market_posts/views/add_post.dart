import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/dashboard/profile/view_model/profile_vm.dart';
import 'package:market_connect/src/features/market_posts/models/market_post.dart';
import 'package:market_connect/src/features/market_posts/view_model/market_post_vm.dart';
import 'package:market_connect/src/utilities/insets/insets.dart';
import 'package:market_connect/src/utilities/styles/theme.dart';
import 'package:market_connect/src/utilities/widgets/spacing.dart';

class AddMarketPost extends ConsumerStatefulWidget {
  const AddMarketPost({super.key});

  @override
  ConsumerState<AddMarketPost> createState() => _AddMarketPostState();
}

class _AddMarketPostState extends ConsumerState<AddMarketPost> {
  final marketPost = MarketPost.empty();
  File? postImage;
  late TextEditingController captionController;
  bool isUploading = false;
  final emptyPost = MarketPost.empty();
  @override
  void initState() {
    captionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(profileVmProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Market Post"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: isUploading
                  ? null
                  : () {
                      FocusScope.of(context).unfocus();
                      setState(() {
                        isUploading = true;
                      });
                      ref.read(marketPostVmProvider.notifier).uploadPost(
                          userId: currentUser.uid,
                          post:
                          MarketPost(
                            createdAt: DateTime.now(),
                            authorId: currentUser.uid,
                            postId: "",
                            caption: captionController.text,
                            likes: [],
                            comments: [],
                            imageUrl: "",
                          ),
                          postImage: postImage);

                          ref.refresh(profilePostsVmProvider(currentUser.uid));

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: MarketKonnetColor.primary[200],
                          content: const Text("Successfully Posted"),
                        ),
                      );
                      Navigator.pop(context);
                    },
              icon: const Icon(Icons.done),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Visibility(
                visible: isUploading,
                child: const LinearProgressIndicator(),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(Insets.medium),
                  child: TextFormField(
                    controller: captionController,
                    maxLines: 5,
                    decoration: const InputDecoration(),
                  ),
                ),
              ),
              Spacing.vertical( 32),
              postImage == null
                  ? const Expanded(child: SizedBox())
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.24,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                        fit: BoxFit.contain,
                          image: FileImage(postImage!),
                        ),
                      ),
                    ),
              Spacing.vertical( 32),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: isUploading
              ? null
              : () async {
                  postImage =
                      await ref.read(marketPostVmProvider.notifier).pickImage();
                  setState(() {});
                },
          child: const Icon(Icons.photo),
        ));
  }
}
