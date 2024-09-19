

import '../../helpers/imports.dart';

class CreateUserBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<CreateUserController>(CreateUserController());
  }
}
