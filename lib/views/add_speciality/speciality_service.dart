import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kpksmartguide/views/add_speciality/speciality_model.dart';

class SpecialityService {
  final CollectionReference _hotelsCollection =
      FirebaseFirestore.instance.collection('specialities');

  Future<void> addSpeciality(Map<String, dynamic> data) async {
    await _hotelsCollection.add(data);
  }

  Future<void> updateHotel(String id, Map<String, dynamic> data) async {
    await _hotelsCollection.doc(id).update(data);
  }

  Future<void> deleteHotel(String id) async {
    await _hotelsCollection.doc(id).delete();
  }

  // getHotels method returns a Hotel object
  Future<List<Speciality>> getSpecialities() async {
    var hotel = await _hotelsCollection.get();
    List<Speciality> specialities = [];
    hotel.docs.forEach((element) {
      specialities
          .add(Speciality.fromMap(element.data() as Map<String, dynamic>));
    });

    return specialities;
  }
}
