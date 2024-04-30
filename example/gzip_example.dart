// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

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
