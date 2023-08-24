import 'package:fluent_ui/fluent_ui.dart';


class viewFactory extends StatelessWidget {
  const viewFactory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Center(
        child: Text("aqui ira la lista de empres"),
      ),
    );
  }
}