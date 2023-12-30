import 'package:flutter/material.dart';
import 'package:market_connect/src/features/interview_prep/firestore_service/firestore_service.dart';
import 'package:market_connect/src/features/interview_prep/model/prep_detail.dart';
import 'package:market_connect/src/features/interview_prep/viewmodel/prep_viewmodel/prep_vm.dart';

class GetDetailPage extends StatefulWidget {
  const GetDetailPage({super.key});

  @override
  State<GetDetailPage> createState() => _GetDetailPageState();
}

class _GetDetailPageState extends State<GetDetailPage> {
  final prepVM = PrepVM(fService: FirestoreService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: StreamBuilder(
                stream: prepVM.getDetailStream(),
                builder: (context, snapshots) {
                  if (snapshots.hasData) {
                    final data = snapshots.data ?? [];
                    return Column(
                      children: List.generate(
                        data.length,
                        (index) => Text("${index + 1}. ${data[index].name}"),
                      ),
                    );
                  }
                  if (snapshots.connectionState==ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return const Text("Error Occured");
                })
            /*FutureBuilder<PrepDetail>(
              future: prepVM.getPrepDetail(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  final prepDetail = snapshot.data;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text("address = ${prepDetail?.address}"),
                      ),Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text("name = ${prepDetail?.name}"),
                      ),Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text("email = ${prepDetail?.email}"),
                      ),Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text("phone = ${prepDetail?.phone}"),
                      )
                    ],
                  );
                }
                return const Text("Error Occured");
              }),*/
            ),
      ),
    );
  }
}
