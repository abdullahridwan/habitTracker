import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tracker/Firebase/config.dart';

class FirebaseHelper<T> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName;
  final T Function(String, Map<String, dynamic>) _fromMap;
  final Map<String, dynamic> Function(T item) _toMap;

  FirebaseHelper(
    this._collectionName, {
    required T Function(String, Map<String, dynamic>) fromMap,
    required Map<String, dynamic> Function(T) toMap,
  })  : _fromMap = fromMap,
        _toMap = toMap;

  Future<String> add(T item) async {
    final Map<String, dynamic> data = _toMap(item);
    final DocumentReference documentReference =
        await _firestore.collection(_collectionName).add(data);
    return documentReference.id;
  }

  Future<T?> get(String id) async {
    final DocumentSnapshot snapshot =
        await _firestore.collection(_collectionName).doc(id).get();
    if (snapshot.exists) {
      return _fromMap(snapshot.id, snapshot.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> update(String id, T item) async {
    final Map<String, dynamic> data = _toMap(item);
    await _firestore.collection(_collectionName).doc(id).update(data);
  }

  Future<void> delete(String id) async {
    await _firestore.collection(_collectionName).doc(id).delete();
  }

  Stream<List<T>> getAll() {
    String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? "";

    return _firestore
        .collection(CONFIG['collectionName']!)
        .where('userId', isEqualTo: currentUserId)
        .orderBy(CONFIG['orderBy']!)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs
          .map((QueryDocumentSnapshot document) =>
              _fromMap(document.id, document.data() as Map<String, dynamic>))
          .toList();
    });
  }
}
