import 'package:getx/helpers/imports.dart';

class SecondScreen extends StatelessWidget {
  final String navigationType;

  const SecondScreen({super.key, required this.navigationType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(navigationType == simpleNavigation ? simpleSecondScreen :namedSecondScreen),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Navigate and remove the current screen
          Center(
              child: CommonElevatedButton(
            buttonName: 'Get.off(ThirdScreen());',
            onPressed: () {
              if (navigationType == simpleNavigation) {
                Get.off(() => ThirdScreen(
                      navigationType: navigationType,
                    ));
              } else {
                Get.offNamed(Routes.thirdScreen, arguments: navigationType);
              }
            },
          )),
          const Text("Go to Third Screen using (Get.off)"),
// Go back

          Center(
              child: CommonElevatedButton(
            buttonName: 'Go to First Screen using (Get.back)',
            onPressed: () {
              Get.back();
            },
          )),
          const Text("Go back to  First Screen (Get.back)"),
        ],
      ),
    );
  }
}
