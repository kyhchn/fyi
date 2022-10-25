import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CloudStorageService {
  File? file;
  final firebaseStorage = FirebaseStorage.instance.ref();
  CloudStorageService({this.file});
  Future<String?> uploadFile(String path) async {
    String baseName = basename(file!.path);
    final storageRef = firebaseStorage.child("$path/$baseName");
    try {
      await storageRef.putFile(file!);
      return storageRef.fullPath;
    } catch (e) {
      return null;
    }
  }

  Future<String?> uploadImage(String path) async {
    String baseName = basename(file!.path);
    final storageRef = firebaseStorage.child("$path/$baseName");
    try {
      await storageRef.putFile(file!);
      return storageRef.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  Future<String?> getImageUrl(String path) async {
    final storageRef = firebaseStorage.child(path);
    return await storageRef.getDownloadURL();
  }

  Future<File?> downloadFile(String path) async {
    final ref = firebaseStorage.child(path);
    final tempDocDir = await getTemporaryDirectory();
    final filePath = "${tempDocDir.path}/${ref.name}";
    final file = File(filePath);
    final downloadTask = await ref.writeToFile(file);
    if (downloadTask.state == TaskState.success) {
      return file;
    } else {
      return null;
    }
  }
}
