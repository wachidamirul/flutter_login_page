import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final box = GetStorage();
  var isDarkMode = false.obs;

  ThemeController() {
    isDarkMode.value = box.read('isDarkMode') ?? false;
  }

  void setTheme(bool value) {
    isDarkMode.value = value;
    box.write('isDarkMode', value);
  }
}
