import '../helpers/imports.dart';

abstract class Pages {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: Routes.firstScreen,
      page: () => FirstScreen(navigationType: Get.arguments ?? "default"),
    ),
    GetPage(
      name: Routes.secondScreen,
      page: () => SecondScreen(navigationType: Get.arguments ?? "default"),
    ),
    GetPage(
      name: Routes.thirdScreen,
      page: () => ThirdScreen(navigationType: Get.arguments ?? "default"),
    ),
    GetPage(
      name: Routes.fourthScreen,
      page: () => FourthScreen(navigationType: Get.arguments ?? "default"),
    ),
    GetPage(
        name: Routes.createUserScreen,
        page: () => const CreateOrEditUserScreen(),
        binding: CreateUserBindings()),
    GetPage(
        name: Routes.viewUserScreen,
        page: () => const ViewUserScreen(),
        binding: CreateUserBindings()),
  ];
}
