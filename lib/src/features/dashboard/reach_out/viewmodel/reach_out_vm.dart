import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/dashboard/reach_out/model/reach_out.dart';
import 'package:market_connect/src/features/dashboard/reach_out/repository/reach_out_repository.dart';

class ReachOutViewmodel {
  const ReachOutViewmodel(this.repo);
  final ReachOutRepository repo;

  void sendMessage(ReachOut reachOut) async {
    repo.sendMessage(reachOut);
  }

  Stream<List<ReachOut>> getMessages({
    required String primaryUserId,
    required String secondaryUserId,
  }) {
    print("in Vm");
    return repo.getMessages(
      primaryUserId: primaryUserId,
      secondaryUserId: secondaryUserId,
    );
  }

  Stream<List<String>> getReachOutOverview(String primaryUserId){
    return repo.getReachOutOverview(primaryUserId);
  }
}

final reachOutVMProvider = Provider<ReachOutViewmodel>((ref) {
  final repo = ref.read(reachOutRepoProvider);
  return ReachOutViewmodel(repo);
});

final dmStreamProvider = StreamProvider<List<ReachOut>>((ref) {
  print("in rOSP");
  final vm = ref.read(reachOutVMProvider);
  return vm.getMessages(
    primaryUserId: "t4PqkxaGQiP02K9S4zotn0SPKvJ3",
    secondaryUserId: "AbU2huTVOrhP4wvclglMnVfr5wg1",
  );
});

final reachOutOverviewProvider = StreamProvider((ref) {
  final vm = ref.read(reachOutVMProvider);
  return vm.getReachOutOverview("t4PqkxaGQiP02K9S4zotn0SPKvJ3");

});