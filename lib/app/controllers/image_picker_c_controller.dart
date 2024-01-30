import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerCController extends GetxController {
  static Future<XFile?> pickImageFrom(ImageSource source) async =>
      await ImagePicker().pickImage(source: source);
}
