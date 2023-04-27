import 'dart:typed_data';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:printing/printing.dart';

import '../../util/image_file.dart';

class PdfPreviewPage extends StatelessWidget {
  final String? title;
  final Uint8List bytes;
  // final PdfPageFormat? format;
  // final UserConfigProvider? ap;
  const PdfPreviewPage({
    Key? key,
    this.title,
    required this.bytes,
    // this.format,
    // this.ap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      // appBar: AppBar(
      //   backgroundColor: Colors.green,
      //   title: Text(
      //     title!,
      //     maxLines: 2,
      //     style: TextStyle(fontSize: 14),
      //   ),
      //   actions: [
      //     Image.asset(Images.proshika1Logo),
      //   ],
      // ),
      content: PdfPreview(
        canDebug: false,
        pdfFileName: '$title.pdf',
        build: (context) => bytes,
      ),
    );
  }
}
