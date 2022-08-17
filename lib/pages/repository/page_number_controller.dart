import 'package:get/get.dart';

class PageNumberController extends GetxController {
  var page = 1.obs;

  void next() {
    page++;
    update();
  }

  void prev() {
    if (page > 1) {
      page--;
      update();
    }
  }

  void up(int newPage) {
    page = newPage.obs;
    update();
  }

  void reset() {
    page = 1.obs;
    update();
  }
}
