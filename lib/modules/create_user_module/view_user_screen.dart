import 'package:getx/helpers/imports.dart';

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.userList.length,
                  itemBuilder: (context, index) {
                    UserModel userModel = controller.userList[index];
                    return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text("Name :- ${userModel.name}"),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Description :- ${userModel.description}"),
                                  Text("User Id :- ${userModel.id}"),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () async {
                                        await Get.toNamed(
                                            Routes.createUserScreen,
                                            arguments: {
                                              "userModel": userModel,
                                              "isFromEdit": true
                                            });
                                        controller.getUser();
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        controller.deleteUser(userModel.id!);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ));
                  },
                ),
              ),
              CommonElevatedButton(
                buttonName: "Create User",
                onPressed: () async {
                  await Get.toNamed(Routes.createUserScreen,
                      arguments: {"isFromEdit": false});
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
