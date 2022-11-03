import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/model/market_user.dart';
import 'package:market_connect/src/features/market_posts/view_model/market_post_vm.dart';
import 'package:market_connect/src/features/market_posts/widgets/market_post_card.dart';
import 'package:market_connect/src/utilities/styles/theme.dart';
import 'package:market_connect/src/utilities/widgets/asyncwidgets.dart';

class ProfilePostView extends ConsumerStatefulWidget {
  const ProfilePostView({required this.user, super.key});
  final MarketUser user;

  @override
  ConsumerState<ProfilePostView> createState() => _ProfilePostViewState();
}

class _ProfilePostViewState extends ConsumerState<ProfilePostView> {
  @override
  Widget build(BuildContext context) {
    final userPostsVm = ref.watch(profilePostsVmProvider(widget.user.uid));
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.user.marketName} Posts"),
      ),
      backgroundColor: MarketKonnetColor.primary[100],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: userPostsVm.when(
          data: (posts) => ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (context, index) => MarketPostCard(author: widget.user,post: posts[index]),
          ),
          error: (error, stacktrace) => AsyncErrorWidget(
            errorMessage: "Error Ocurred, Try Again",
            ref: ref,
            onRefresh: () => ref.refresh(
              profilePostsVmProvider(widget.user.uid),
            ),
          ),
          loading: () => const AsyncLoadingWidget(),
        ),
      ),
    );
  }
}
