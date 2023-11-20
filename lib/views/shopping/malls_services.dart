import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kpksmartguide/views/shopping/malls_model.dart';

class MallsService {
  final CollectionReference _mallsCollection =
      FirebaseFirestore.instance.collection('malls');

  Future<void> addMall(Map<String, dynamic> data) async {
    await _mallsCollection.add(data);
  }

  Future<void> updateMall(String id, Map<String, dynamic> data) async {
    await _mallsCollection.doc(id).update(data);
  }

  Future<void> deleteMall(String id) async {
    await _mallsCollection.doc(id).delete();
  }

  // getmalls method returns a Hotel object
  Future<List<MallsModel>> getMalls() async {
    var hotel = await _mallsCollection.get();
    List<MallsModel> malls = [];
    hotel.docs.forEach((element) {
      malls.add(MallsModel.fromMap(element.data() as Map<String, dynamic>));
    });

    return malls;
  }
}
