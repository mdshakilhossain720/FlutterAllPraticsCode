import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {
  // singleton instance
  static final ImagePickerUtils _instance = ImagePickerUtils._internal();

  factory ImagePickerUtils() => _instance;

  ImagePickerUtils._internal();

  // Method to pick an image from the gallery
  Future<File?> pickImageFromGallery() async {
    ImagePicker picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        return File(value.path);
      }
      return null;
    });
  }

  // Method to capture an image using the camera
  Future<File?> pickImageFromCamera() async {
    return null; // Return null if no image was captured
  }
}
