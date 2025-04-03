import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class UtilsImagePickerProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imagesList;
  XFile? _image;
  String? _pickImageError;

  List<XFile>? get imageList => _imagesList;
  XFile? get image => _image;
  String? get pickImageError => _pickImageError;

  Future<void> pickImage({
    required ImageSource source,
    bool isMultiImage = false,
    double? maxWidth,
    double? maxHeight,
    int? quality,
  }) async {
    try {
      if (isMultiImage) {
        final List<XFile> selectedImages = await _picker.pickMultiImage(
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: quality,
        );
        debugPrint('selectedImages: $selectedImages');
        _imagesList = selectedImages;
      } else {
        final XFile? selectedImage = await _picker.pickImage(
          source: source,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: quality,
        );
        if (selectedImage != null) {
          _image = selectedImage;
        }
      }
      _pickImageError = null;
    } on PlatformException catch (e) {
      _pickImageError = e.toString();
    }
    notifyListeners();
  }

  void clearImages() {
    _imagesList = null;
    _pickImageError = null;
    notifyListeners();
  }
}