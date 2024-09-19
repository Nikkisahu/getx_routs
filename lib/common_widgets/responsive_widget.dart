
import 'package:getx/helpers/imports.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget desktop, tablet, mobile;

  const ResponsiveWidget(
      {super.key,
        required this.desktop,
        required this.tablet,
        required this.mobile});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1366) {
          return desktop;
        } else if (constraints.maxWidth < 1366 && constraints.maxWidth >= 768) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}
