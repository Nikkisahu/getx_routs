import 'package:getx/helpers/imports.dart';

class CreateOrEditUserScreen extends GetView<CreateUserController> {
  final UserModel? userModel;

  const CreateOrEditUserScreen({super.key, this.userModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CreateUserController>(
        init: CreateUserController(),
        initState: (state) {
          if (userModel != null) {
            if (kDebugMode) {
              print("userModel...${userModel!.name}");
              controller.nameController.text = userModel!.name!;
              controller.descriptionController.text = userModel!.description!;
            }
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
                    buttonName: userModel != null ? "Edit" : "Create",
                    onPressed: () {
                      if (userModel != null) {
                        controller.editUser(userModel!.id!);
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
