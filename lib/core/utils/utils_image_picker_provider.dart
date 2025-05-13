import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';

abstract class ImagePickerService {
  Future<XFile?> pickSingleImage({
    required ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int? quality,
  });

  Future<List<XFile>> pickMultiImages({
    double? maxWidth,
    double? maxHeight,
    int? quality,
  });
}

abstract class ImageValidator {
  Future<bool> isValidSize(String path);
}

abstract class ImageConverter {
  Future<MultipartFile> toMultipartFile(XFile image);
}

class ImagePickerServiceImp implements ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<XFile?> pickSingleImage({
    required ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int? quality,
  }) async {
    return await _picker.pickImage(
      source: source,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: quality,
    );
  }

  @override
  Future<List<XFile>> pickMultiImages({
    double? maxWidth,
    double? maxHeight,
    int? quality,
  }) async {
    return await _picker.pickMultiImage(
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: quality,
    );
  }
}

class ImageValidatorImp implements ImageValidator {
  static const int maxFileSize = 4 * 1024 * 1024;

  @override
  Future<bool> isValidSize(String path) async {
    final file = File(path);
    final size = await file.length();
    return size <= maxFileSize;
  }
}

class ImageConverterImp implements ImageConverter {
  @override
  Future<MultipartFile> toMultipartFile(XFile image) async {
    if (kIsWeb) {
      final bytes = await image.readAsBytes();
      return MultipartFile.fromBytes(bytes, filename: image.name);
    } else {
      return await MultipartFile.fromFile(image.path, filename: image.name);
    }
  }
}

class UtilsImagePickerProvider extends ChangeNotifier {
  final ImagePickerService pickerService;
  final ImageValidator validator;
  final ImageConverter converter;

  XFile? image;
  Uint8List? imageWeb;
  List<XFile>? imageList;
  List<Uint8List>? imageListWeb;
  MultipartFile? imageFile;

  UtilsImagePickerProvider({
    required this.pickerService,
    required this.validator,
    required this.converter,
  });
  Future<void> pickSingleImage({
    required ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int? quality,
  }) async {
    try {
      final picked = await pickerService.pickSingleImage(
        source: source,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        quality: quality,
      );
      if (picked == null) {
        SnackBarService.show(status: SnackBarStatus.error, message: AppMessage.pickImageError);
        return;
      }
      if (!kIsWeb) {
        if (await validator.isValidSize(picked.path)) {
          image = picked;
        } else {
          SnackBarService.show(
              status: SnackBarStatus.error, message: AppMessage.fileSizeShouldBeLessThan4MB);
          return;
        }
      } else {
        imageWeb = await picked.readAsBytes();
      }

      imageFile = await converter.toMultipartFile(picked);
    } catch (_) {
      SnackBarService.show(status: SnackBarStatus.error, message: AppMessage.pickImageError);
    }
    notifyListeners();
  }

  Future<void> pickMultipleImages({
    double? maxWidth,
    double? maxHeight,
    int? quality,
  }) async {
    try {
      final pickedList = await pickerService.pickMultiImages(
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        quality: quality,
      );

      for (var image in pickedList) {
        if (!kIsWeb && !await validator.isValidSize(image.path)) {
          SnackBarService.show(
              status: SnackBarStatus.error, message: AppMessage.fileSizeShouldBeLessThan4MB);
          return;
        }
      }

      imageList = kIsWeb ? null : pickedList;
      imageListWeb = kIsWeb ? await Future.wait(pickedList.map((e) => e.readAsBytes())) : null;
    } catch (_) {
      SnackBarService.show(status: SnackBarStatus.error, message: AppMessage.pickImageError);
    }
    notifyListeners();
  }

  void clear() {
    image = null;
    imageWeb = null;
    imageList = null;
    imageListWeb = null;
    imageFile = null;
    notifyListeners();
  }
}
