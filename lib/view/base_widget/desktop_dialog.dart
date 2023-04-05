import 'package:fluent_ui/fluent_ui.dart';

showContentDialog(String title, BuildContext context, VoidCallback fn) async {
  await showDialog<String>(
    context: context,
    builder: (context) => ContentDialog(
      title: const Text('Exit'),
      content: Text(
        title,
      ),
      actions: [
        Button(
          child: const Text('YES'),
          onPressed: () {
            fn();
            // Delete file here
          },
        ),
        FilledButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}
