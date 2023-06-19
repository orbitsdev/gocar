import 'package:get/get.dart';
import 'package:gocar/controllers/auth/auth_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
     Get.put(AuthController(), permanent: true);
  }
  
}

