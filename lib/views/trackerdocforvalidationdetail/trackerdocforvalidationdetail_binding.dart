import 'package:get/get.dart';
import 'trackerdocforvalidationdetail_controller.dart';

class TrackerdocforvalidationdetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackerdocforvalidationdetailController>(
      () => TrackerdocforvalidationdetailController(),
    );
  }
}
