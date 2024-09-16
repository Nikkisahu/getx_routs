import 'package:getx/helpers/imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: CommonElevatedButton(
            buttonName: simpleNavigation,
            onPressed: () {
              Get.to(() => FirstScreen(navigationType: simpleNavigation));
            },
          )),
          Center(
              child: CommonElevatedButton(
            buttonName: namedNavigation,
            onPressed: () {
              Get.toNamed(Routes.firstScreen, arguments: namedNavigation);
            },
          )),
        ],
      ),
    );
  }
}
