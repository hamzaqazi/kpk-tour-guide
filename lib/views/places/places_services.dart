import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kpksmartguide/views/places/places_model.dart';

class PlacesService {
  final CollectionReference placesCollection =
      FirebaseFirestore.instance.collection('places');

  Future<List<Place>> getPlaces() async {
    QuerySnapshot querySnapshot = await placesCollection.get();
    return querySnapshot.docs
        .map((doc) => Place.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> addPlace(Place place) async {
    await placesCollection.add(place.toMap());
  }

  Future<void> updatePlace(String documentId, Place updatedPlace) async {
    await placesCollection.doc(documentId).update(updatedPlace.toMap());
  }

  Future<void> deletePlace(String documentId) async {
    await placesCollection.doc(documentId).delete();
  }
}
