import 'package:getx/helpers/imports.dart';

class CreateOrEditUserScreen extends GetView<CreateUserController> {
/*
  final UserModel? userModel;
*/

  const CreateOrEditUserScreen({
    super.key,
    /*this.userModel*/
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CreateUserController>(
        init: CreateUserController(),
        initState: (state) {
          if (Get.arguments["isFromEdit"] == true) {
            // if (kDebugMode) {
            //   print("userModel...${Get.arguments["userModel"].description}");
            // }
            controller.nameController.text = Get.arguments["userModel"].name!;
            controller.descriptionController.text =
                Get.arguments["userModel"].description!;
          } else {
            controller.nameController.clear();
            controller.descriptionController.clear();
          }
        },
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonTextFieldWidget(
                    controller: controller.nameController,
                    hintText: "Name",
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CommonTextFieldWidget(
                    controller: controller.descriptionController,
                    hintText: "Description",
                  ),
                  CommonElevatedButton(
                    buttonName:
                        Get.arguments["isFromEdit"] == true ? "Edit" : "Create",
                    onPressed: () {
                      if (Get.arguments["isFromEdit"] == true) {
                        controller.editUser(Get.arguments["userModel"].id!);
                      } else {
                        controller.createUser();
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
