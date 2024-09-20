import 'package:getx/helpers/imports.dart';

class CommonTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;

  final String? hintText;

  const CommonTextFieldWidget({super.key, this.controller, this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
    );
  }
}
