import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/model/market_user.dart';
import 'package:market_connect/src/features/dashboard/profile/view/primary_profile_view.dart';
import 'package:market_connect/src/features/dashboard/profile/view/secondary_profile_view.dart';
import 'package:market_connect/src/features/market_posts/view_model/market_post_vm.dart';
import 'package:market_connect/src/features/dashboard/profile/view_model/profile_vm.dart';
import 'package:market_connect/src/features/market_posts/models/market_post.dart';
import 'package:market_connect/src/utilities/extensions/timeago_extension.dart';
import 'package:market_connect/src/utilities/widgets/spacing.dart';

class MarketPostCard extends ConsumerStatefulWidget {
  const MarketPostCard({
    required this.author,
    required this.post,
    super.key,
  });
  final MarketPost post;
  final MarketUser author;

  @override
  ConsumerState<MarketPostCard> createState() => _MarketPostCardState();
}

class _MarketPostCardState extends ConsumerState<MarketPostCard> {
  void likePost(MarketPost post, String primaryUser) {
    ref.read(marketPostVmProvider.notifier).likePost(post, primaryUser);
    setState(() {
      widget.post.likes.contains(primaryUser)
          ? widget.post.likes.remove(primaryUser)
          : widget.post.likes.add(primaryUser);
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryUser = ref.watch(profileVmProvider);
    final screenSize = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: widget.author.photoUrl.isEmpty
                      ? null
                      : CachedNetworkImageProvider(widget.author.photoUrl),
                  child: widget.author.photoUrl.isNotEmpty
                      ? null
                      : Text(widget.author.marketName[0]),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => widget.author == primaryUser
                        ? const PrimaryProfileView()
                        : SecondaryProfileView(secondaryUser: widget.author),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.author.marketName),
                    Text(widget.post.createdAt.toLocal().timeago()),
                  ],
                ),
              ),
            ],
          ),
        ),
        Spacing.vertical(12),
        Container(
          //height: screenSize.height * 0.28,
          width: screenSize.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: CachedNetworkImage(
            imageUrl: widget.post.imageUrl,
            placeholder: (context, url) => const Center(
              child: LinearProgressIndicator(),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => likePost(widget.post, primaryUser.uid),
                  icon: Icon(
                    widget.post.likes.contains(primaryUser.uid)
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                ),
              ],
            ),
            widget.post.likes.isNotEmpty
                ? Text("${widget.post.likes.length}like(s)")
                : const SizedBox(),
            IconButton(
              onPressed: () {
                ref.read(marketPostVmProvider.notifier).deletePost(widget.post);
                ref.refresh(marketPostVmProvider);
              },
              icon: const Icon(Icons.delete_forever),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 12),
          child: Text(
            widget.post.caption,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 12),
          child: GestureDetector(
            onTap: () {},
            child: Text(widget.post.comments.isEmpty
                ? "Add comment"
                : "View all comment"),
          ),
        ),
        const Divider(thickness: 2)
      ],
    );
  }
}
