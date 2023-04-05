import 'package:fluent_ui/fluent_ui.dart';

class ImgScreen extends StatefulWidget {
  const ImgScreen({super.key});

  @override
  State<ImgScreen> createState() => _ImgScreenState();
}

class _ImgScreenState extends State<ImgScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: Text('Image'),
      ),
      content: Column(
        children: [
          // InteractiveViewer(
          //     maxScale: 4,
          //     child: Container(
          //         height: 500,
          //         width: 500,
          //         child: Image.network('https://easyfashion.com.bd/wp-content/uploads/2023/03/DSC06516-1-scaled.jpg'))),
        ],
      ),
    );
  }
}
