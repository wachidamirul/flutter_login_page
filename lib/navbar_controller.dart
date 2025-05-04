import 'package:get/get.dart';

class NavbarController extends GetxController {
  var currentIndex = 0.obs;

  getIndex() => currentIndex.value;
  setIndex(int index) => currentIndex.value = index;
}
