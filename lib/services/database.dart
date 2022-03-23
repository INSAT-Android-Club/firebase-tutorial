import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getCollection(String path,[int? length,DocumentSnapshot? snapshot]) {
    if(length!=null){
      if(snapshot!=null){
        return _firestore.collection(path).limit(length).startAfterDocument(snapshot).get();
      }else{
        return _firestore.collection(path).limit(length).get();
      }
    }else{
      if(snapshot!=null){
        return _firestore.collection(path).startAfterDocument(snapshot).get();
      }else{
        return _firestore.collection(path).get();
      }
    }
  }

  Stream<QuerySnapshot> getStreamCollection(String path) {
    return _firestore.collection(path).snapshots();
  }

  Future<DocumentSnapshot> getDocument(String path) {
    return _firestore.doc(path).get();
  }

  Stream<DocumentSnapshot> getStreamDocument(String path) {
    return _firestore.doc(path).snapshots();
  }

  Future<void> createDocument(String path, Map<String, dynamic> data) {
    return _firestore.doc(path).set(data);
  }

  Future<void> updateDocument(String path, Map<String, dynamic> data) {
    return _firestore.doc(path).update(data);
  }

  Future<void> deleteDocument(String path) {
    return _firestore.doc(path).delete();
  }
}
