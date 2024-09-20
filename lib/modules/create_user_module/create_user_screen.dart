import 'package:getx/helpers/imports.dart';

class CreateUserScreen extends GetView<CreateUserController> {
  const CreateUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CreateUserController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
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
                const Spacer(),
                CommonElevatedButton(
                  buttonName: "Create",
                  onPressed: () {
                    controller.createUser();
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
