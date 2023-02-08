import 'package:easy_note/core/utils/get_default_dir.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

enum ImagePickerEnum {
  camera,
  gallery;

  const ImagePickerEnum();

  ImageSource fromImagePicker(ImagePickerEnum source) {
    return ImageSource.values.firstWhere((item) => item.index == source.index);
  }
}

abstract class ImagePickerAbstract {
  Future<String?> getImage(ImagePickerEnum source, String folderToSave);
}

class ImagePickerEasyNote implements ImagePickerAbstract {
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Future<String?> getImage(ImagePickerEnum source, String folderToSave) async {
    try {
      XFile? file = await _imagePicker.pickImage(source: source.fromImagePicker(source));

      if (file != null) {
        String path = await getDefaultDir();
        path += "/$folderToSave";
        String ext = extension(file.path);
        String nameFile = "${UniqueKey().hashCode}$ext";
        path += "/$nameFile";

        await file.saveTo(path);

        return path;
      }
    } catch (_) {
      return null;
    }

    return "";
  }
}