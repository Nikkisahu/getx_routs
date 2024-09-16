import 'package:getx/helpers/imports.dart';

class ThirdScreen extends StatelessWidget {
  final String navigationType;

  const ThirdScreen({super.key, required this.navigationType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(navigationType == simpleNavigation
            ? simpleThirdScreen
            : namedThirdScreen),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Go to Fourth Screen (Get.offAll)"),
          Center(
              child: CommonElevatedButton(
            buttonName: ' Get.offAll(FourthScreen());',
            onPressed: () {
              if (navigationType == simpleNavigation) {
                Get.offAll(() => FourthScreen(
                      navigationType: navigationType,
                    ));
              } else {
                Get.offAllNamed(Routes.fourthScreen, arguments: navigationType);
              }
            },
          )),
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
