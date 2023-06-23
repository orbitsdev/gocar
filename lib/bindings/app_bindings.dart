import 'package:get/get.dart';
import 'package:gocar/controllers/auth/auth_controller.dart';
import 'package:gocar/controllers/rental/rental_controller.dart';
import 'package:gocar/controllers/user/profile_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
     Get.put(AuthController(), permanent: true);
     Get.put(RentalController(), permanent: true);
     Get.put(ProfileController(), permanent: true);
  }
  
}

