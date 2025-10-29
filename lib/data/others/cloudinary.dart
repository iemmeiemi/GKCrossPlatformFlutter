
import 'dart:io';

import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_api/src/request/model/uploader_params.dart';

class CloudinaryServices {
  Cloudinary cloudinary = Cloudinary.fromStringUrl('cloudinary://255685418237618:sDqmZ3BnBdRIn9wLLPGYqzdVdSo@dg5bbcr28');

  Future<String?> uploadImage(File file) async {
    try {
      final response = await cloudinary.uploader().upload(
      file,
      params: UploadParams(uploadPreset: "giuaky", type: "raw"),
      );
      print(response?.error?.message);
      return response?.data?.secureUrl;
    } on Exception catch (e) {
      print("Cloudianary error: $e");
    }
  }
}