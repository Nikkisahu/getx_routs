import 'dart:math';

import 'package:getx/helpers/imports.dart';

class CreateUserController extends GetxController {
  String? name, description;
  List<UserModel> userList = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  UserModel? userModel;
  int random = Random().nextInt(1000);

  /*Future<void> savePersonList(List<UserModel> persons) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonStringList =
        persons.map((person) => jsonEncode(person.toJson())).toList();
    await prefs.setStringList('person_list', jsonStringList);
  }*/

  Future<void> createUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = "$random${DateTime.now().microsecondsSinceEpoch}";

    // prefs.setString('name', nameController.text.trim());
    // prefs.setString('description', descriptionController.text.trim());
    userList.add(UserModel(
        id: id,
        name: nameController.text.trim(),
        description: descriptionController.text.trim()));
    List<String> jsonStringList =
        userList.map((person) => jsonEncode(person.toJson())).toList();
    await prefs.setStringList('user_list', jsonStringList);
    update();
    Get.back();
    nameController.clear();
    descriptionController.clear();
  }

  Future<void> editUser(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int index = userList.indexWhere((user) => user.id == id);

    if (index != -1) {
      userList[index] = UserModel(
          id: id,
          name: nameController.text.trim(),
          description: descriptionController.text.trim());
      List<String> jsonStringList =
          userList.map((person) => jsonEncode(person.toJson())).toList();
      await prefs.setStringList('user_list', jsonStringList);

      update();
      Get.back();
      nameController.clear();
      descriptionController.clear();
    } else {
      if (kDebugMode) {
        print('User not found');
      }
    }
  }

  Future<void> deleteUser(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int index = userList.indexWhere((user) => user.id == id);

    if (index != -1) {
      userList.removeAt(index);
      List<String> jsonStringList =
          userList.map((person) => jsonEncode(person.toJson())).toList();
      await prefs.setStringList('user_list', jsonStringList);

      update();
    } else {
      if (kDebugMode) {
        print('User not found');
      }
    }
  }

  Future<List<UserModel>> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // name = prefs.getString('name');
    // description = prefs.getString('description');
    List<String>? userData = prefs.getStringList("user_list");
    if (userData != null) {
      return userData.map((e) => UserModel.fromJson(jsonDecode(e))).toList();
    }
    return [];
  }
}
