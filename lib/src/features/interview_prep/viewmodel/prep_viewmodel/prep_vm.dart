import 'package:market_connect/src/features/interview_prep/firestore_service/firestore_service.dart';
import 'package:market_connect/src/features/interview_prep/model/prep_detail.dart';

class PrepVM {
  const PrepVM({required this.fService});
  final FirestoreService fService;

  void addFormInAutoDoc(Map<String,dynamic> dto) async{
    fService.addFormInAutoDoc(dto);
  }
  void addFormWithID(Map<String,dynamic> dto) async{
    fService.addFormWithID(dto);
  }

  Future<PrepDetail> getPrepDetail()async{
    return (await fService.getPrepDetail());
  }

  Stream<List<PrepDetail>> getDetailStream() {
    return fService.getPrepStream();
  }
}