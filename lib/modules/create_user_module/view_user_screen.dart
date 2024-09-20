import 'package:getx/helpers/imports.dart';
import 'package:getx/infrastructure/models/user_model.dart';

class ViewUserScreen extends GetView<CreateUserController> {
  const ViewUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CreateUserController>(
        init: CreateUserController(),
        initState: (state) {
          controller.getUser();
        },
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.userList.length,
                  itemBuilder: (context, index) {
                    UserModel userModel = controller.userList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Name :- ${userModel.name} "),
                          SizedBox(
                            height: 25,
                          ),
                          Text("Description :- ${userModel.description} "),
                        ],
                      ),
                    );
                  },
                ),
              ),
              CommonElevatedButton(
                buttonName: "Create User",
                onPressed: () async {
                  await Get.toNamed(Routes.createUserScreen);
                  controller.getUser();
                },
              )
            ],
          );
        },
      ),
    );
  }
}
