import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/details_model.dart';

class FirestoreUtils {
  static CollectionReference<DetailsModel> getCollection() {
    return FirebaseFirestore.instance
        .collection('wishlist')
        .withConverter<DetailsModel>(
          fromFirestore: (snapshot, _) =>
              DetailsModel.fromFirestore(snapshot.data()!),
          toFirestore: (movie, _) => movie.toFirestore(),
        );
  }

  static Future<void> addDataToFirestore(DetailsModel movie) {
    var collectionRef = getCollection();
    return collectionRef.doc(movie.id.toString()).set(movie);
  }

  static Future<void> deleteDataFromFirestore(DetailsModel movie) {
    var collectionRef = getCollection();
    var docRef = collectionRef.doc(movie.id.toString());
    return docRef.delete();
  }

  static Future<List<DetailsModel>> getDataFromFirestore() async {
    var snapshot = await getCollection().get();
    return snapshot.docs.map((element) => element.data()).toList();
  }

  static Stream<QuerySnapshot<DetailsModel>> getRealTimeDataFromFirestore() {
    var snapshot = getCollection().snapshots();
    print('Snapshot: $snapshot');
    return snapshot;
  }
}
