import 'dart:typed_data';

import 'package:gzip/gzip.dart';

Future<void> main() async {
  final zipper = GZip();
  final input = Uint8List.fromList('Hello World'.codeUnits);
  final compress = await zipper.compress(input);
  print('Encoded: $compress');
  final decompress = await zipper.decompress(Uint8List.fromList(compress));
  print('Decoded: $decompress');
}
