import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Private constructor
  FirestoreService._privateConstructor();

  // Singleton instance
  static final FirestoreService _instance = FirestoreService._privateConstructor();

  // Factory constructor to return the same instance
  factory FirestoreService() {
    return _instance;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getWhereIsEqualTo(String collectionPath, Object field, Object? isEqualTo) async {
    return await _firestore.collection(collectionPath).where(field, isEqualTo: isEqualTo).get();
  }

  Future<DocumentSnapshot> getDocument(String collectionPath, String documentId) async {
    return await _firestore.collection(collectionPath).doc(documentId).get();
  }

  Future<void> setDocument(String collectionPath, String documentId, Map<String, dynamic> data) async {
    await _firestore.collection(collectionPath).doc(documentId).set(data);
  }

  Stream<QuerySnapshot> collectionStream(String collectionPath) {
    return _firestore.collection(collectionPath).snapshots();
  }
}
