import 'package:image_picker/image_picker.dart';

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
        return file.path;
      }
    } catch (_) {
      return null;
    }

    return "";
  }
}