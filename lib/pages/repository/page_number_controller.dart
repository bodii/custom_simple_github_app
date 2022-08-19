import 'package:get/get.dart';

class PageNumberController extends GetxController {
  var page = 1.obs;

  void upPage(int newPage) {
    page = newPage.obs;
    update();
  }

  void reset() {
    page = 1.obs;
    update();
  }
}
