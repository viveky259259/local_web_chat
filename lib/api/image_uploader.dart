//import 'dart:async';
//
//import 'package:firebase_storage/firebase_storage.dart';
//
//class ImageUploader {
//  Future<String> uploadImageToFirebaseStorage(
//      image, String bucketName, String userName) async {
//    var complete = Completer();
//    FirebaseStorage _storage = await FirebaseStorage.instance;
//    //Get the file from the image picker and store it
//    //Create a reference to the location you want to upload to in firebase
//    StorageReference reference = await _storage.ref().child(
//        "$bucketName/${userName.trim()}${DateTime.now().millisecondsSinceEpoch.toString()}");
//    //Upload the file to firebase
//    StorageUploadTask uploadTask = await reference.putFile(image);
//
//    // Waits till the file is uploaded then stores the download url
//    var downloadUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
//    return downloadUrl;
//  }
//}
