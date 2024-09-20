import 'dart:convert';
import 'dart:developer';

import 'package:getx/helpers/imports.dart';
import 'package:getx/infrastructure/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateUserController extends GetxController {
  String? name, description;
  List<UserModel> userList = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  UserModel? userModel;

  /*Future<void> savePersonList(List<UserModel> persons) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonStringList =
        persons.map((person) => jsonEncode(person.toJson())).toList();
    await prefs.setStringList('person_list', jsonStringList);
  }*/

  Future<void> createUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // prefs.setString('name', nameController.text.trim());
    // prefs.setString('description', descriptionController.text.trim());

    userList.add(UserModel(
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

  Future<List<UserModel>> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // name = prefs.getString('name');
    // description = prefs.getString('description');

    List<String>? userData = prefs.getStringList("user_list");
    if (userData != null) {
      return userData.map((e) => UserModel.fromJson(jsonDecode(e))).toList();
    }
    return [];

    log("name...$name");
    log("description...$description");
    update();
  }
}
