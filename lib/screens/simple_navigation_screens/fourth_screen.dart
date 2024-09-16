import 'package:getx/helpers/imports.dart';

class FourthScreen extends StatelessWidget {
  final String navigationType;

  const FourthScreen({super.key, required this.navigationType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(navigationType == simpleNavigation
            ? simpleFourthScreen
            : namedFourthScreen),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: CommonElevatedButton(
            buttonName: ' Get.offAll(HomeScreen());',
            onPressed: () {
              if (navigationType == simpleNavigation) {
                Get.offAll(() => const HomeScreen());
              } else {
                Get.offAllNamed(Routes.homeScreen);
              }
            },
          )),
          const Center(child: Text("All Done Using Simple Get Navigation")),
        ],
      ),
    );
  }
}
