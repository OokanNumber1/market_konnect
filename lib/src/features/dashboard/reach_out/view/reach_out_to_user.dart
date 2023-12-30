import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/model/market_user.dart';
import 'package:market_connect/src/features/authentication/repository/auth_repo.dart';
import 'package:market_connect/src/features/dashboard/reach_out/model/reach_out.dart';
import 'package:market_connect/src/features/dashboard/reach_out/view/widgets/reach_out_box.dart';
import 'package:market_connect/src/features/dashboard/reach_out/viewmodel/reach_out_vm.dart';

class ReachOutToUser extends ConsumerStatefulWidget {
  const ReachOutToUser({
    required this.secondaryUser,
    super.key,
  });
  final MarketUser secondaryUser;
  @override
  ConsumerState<ReachOutToUser> createState() => _ReachOutToUserState();
}

class _ReachOutToUserState extends ConsumerState<ReachOutToUser> {
  final chatController = TextEditingController();

  void sendMessage() {
    FocusScope.of(context).unfocus();
    final vm = ref.read(reachOutVMProvider);
    final primaryUser = ref.read(currentUser);
    vm.sendMessage(
      ReachOut(
        content: chatController.text.trim(),
        receiverId: widget.secondaryUser.uid,
        senderId: primaryUser?.uid ?? "",
        dateTime: DateTime.now()
      ),
    );
    setState(() {});

    chatController.clear();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final secondaryUser = widget.secondaryUser;

    final reachOutsStream = ref.watch(dmStreamProvider);
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.brown[300]!, width: 0.3),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(secondaryUser.fullName),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.8,
              child: SingleChildScrollView(
                child: reachOutsStream.when(
                  data: (reachOuts) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(
                        reachOuts.length,
                        (index) => ReachOutBox(
                          iAmSender:
                              reachOuts[index].senderId != secondaryUser.uid,
                          content: reachOuts[index].content,
                        ),
                      ),
                    );
                  },
                  error: (err, __) => Text(err.toString()),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Flexible(
                  flex: 8,
                  child: TextFormField(
                    controller: chatController,
                    decoration: InputDecoration(
                        focusedBorder: border, enabledBorder: border),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Center(
                    child: InkWell(
                      onTap: sendMessage,
                      child: const Icon(
                        Icons.send,
                        size: 24,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TstnMessage extends StatelessWidget {
  const TstnMessage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> chats = [
      "Hello",
      "Hi",
      "Are you there?",
      "Not yet o. Traffic dey"
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            chats.length,
            (index) => Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
              decoration: BoxDecoration(color: Colors.brown.shade200),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * 0.7),
              child: Text(chats[index]),
            ),
          ),
        ),
      ),
    );
  }
}
