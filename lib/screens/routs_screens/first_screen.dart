import 'package:getx/helpers/imports.dart';

class FirstScreen extends StatelessWidget {
  final String navigationType;

  const FirstScreen({super.key, required this.navigationType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(navigationType == simpleNavigation
            ? simpleFirstScreen
            : namedFirstScreen),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: CommonElevatedButton(
            buttonName: 'Get.to',
            onPressed: () {
              if (navigationType == simpleNavigation) {
                Get.to(() => SecondScreen(navigationType: navigationType));
              } else {
                Get.toNamed(Routes.secondScreen, arguments: navigationType);
              }
            },
          )),
          const Text("Go to Second Screen using (Get.to)"),
        ],
      ),
    );
  }
}
