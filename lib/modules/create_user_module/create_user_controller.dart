import 'dart:math';

import 'package:dio/dio.dart' as Dio;
import 'package:getx/helpers/imports.dart';

import '../../helpers/endpoints.dart';
import '../../infrastructure/api_controller.dart';

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

  void loginMethod(
      // bool? showLoader = true,
      ) async {
    // if (showLoader == true) {
    //   LoadingDialog.showLoader();
    // }
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        "username": "test",
        "password": "Test@123",
        // "category_id": createSelectedCategory.value?.id,
        // "subcategory_id": createSelectedSubCategory.value?.id,
        // "brand_id": createSelectedBrand.value?.id,
        // "sku_no": createSkuController.text,
        // "description": convertDeltaToHTML(createProductQuillController),
        // "description_ar": convertDeltaToHTML(createProductArabicQuillController),
        // "price": createPriceController.text,
        // "price_offer": createSellingPriceController.text,
        // "percentage_discount": createDiscountController.text,
      });

      // if (createProductImageFile != null) {
      //   formData.files.add(MapEntry('imgfile',
      //       await Dio.MultipartFile.fromFile(createProductImageFile!.path)));
      // }
      // if (productVariantList.isNotEmpty) {
      //   for (int i = 0; i < productVariantList.length; i++) {
      //     if (productVariantList[i].isSelected == true) {
      //       if (productVariantList[i].id != null) {
      //         formData.fields.add(MapEntry(
      //             'variant_ids[$i]', productVariantList[i].id!.toString()));
      //       }
      //     }
      //   }
      // }
      Dio.Response response = await ApiProvider().postAPICall(
        Endpoints.login,
        formData,
        passToken: false,
        // onSendProgress: (count, total) {},
      );
      // if (showLoader == true) {
      //   LoadingDialog.hideLoader();
      // }

      if (response.statusCode == 200) {
        // StorageService().writeSecureData(
        //     Constants.email, response['data']['user']['email'] ?? "");

        // Get.toNamed(Routes.createUserScreen);
        // Utils.showToast(response['message'] ?? 'Product created successfully.');
        // Get.back();
        // getProductList(showLoader: false);
        // print(response['data']['user']);
      } else {
        print("response");
        // Utils.showToast(response['message'] ?? 'Failed to create product.');
      }
      // update([createProductId]);
    } on Dio.DioException catch (e) {
      // if (showLoader == true) {
      //   LoadingDialog.hideLoader();
      // }
      // update([createProductId]);

      // Utils.showToast(e.message ?? "Something went wrong");
      debugPrint(e.toString());
    } catch (e) {
      // if (showLoader == true) {
      //   LoadingDialog.hideLoader();
      // }
      // update([createProductId]);
      //
      // Utils.showToast("Something went wrong");
      debugPrint(e.toString());
    }
  }
}
