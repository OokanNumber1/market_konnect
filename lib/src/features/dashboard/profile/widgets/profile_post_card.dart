import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/market_posts/view_model/market_post_vm.dart';
import 'package:market_connect/src/features/market_posts/models/market_post.dart';
import 'package:market_connect/src/utilities/widgets/spacing.dart';

class ProfilePostCard extends ConsumerStatefulWidget {
  const ProfilePostCard({
    required this.post,
    super.key,
  });
  final MarketPost post;

  @override
  ConsumerState<ProfilePostCard> createState() => _ProfilePostCardState();
}

class _ProfilePostCardState extends ConsumerState<ProfilePostCard> {
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
    final screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Spacing.vertical(12),
        Container(
          height: screenSize.height * 0.3,
          width: screenSize.width * 0.48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  blurRadius: 2, spreadRadius: 2, color: Colors.brown[200]!,)
            ],
            image: DecorationImage(
              //TODO: Fix when image upload is optional
              image: CachedNetworkImageProvider(widget.post.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Spacing.vertical(12),

        /* Row(
          children: [
            IconButton(
              onPressed: () => likePost(widget.post, primaryUser.uid),
              icon: Icon(
                widget.post.likes.contains(primaryUser.uid)
                    ? Icons.favorite_border
                    : Icons.favorite,
              ),
            ),
            widget.post.likes.isNotEmpty
                ? Text("${widget.post.likes.length}like(s)")
                : const SizedBox()
          ],
        ),
        TextButton(
          onPressed: () {},
          child: Text(widget.post.comments.isEmpty
              ? "Add comment"
              : "View all comment"),
        )*/
      ],
    );
  }
}
