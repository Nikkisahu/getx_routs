
import 'package:getx/helpers/imports.dart';

class SignInScreen extends GetView<CreateUserController> {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveWidget(
        desktop: GetBuilder<CreateUserController>(
          builder: (controller) {
            return Text("desktop");
          },
        ),
        tablet: GetBuilder<CreateUserController>(
          builder: (controller) {
            return Text("tablet");
          },
        ),
        mobile: GetBuilder<CreateUserController>(
          builder: (controller) {
            return Text("mobile");
          },
        ),
      ),
    );
  }
}
