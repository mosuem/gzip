// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:typed_data';

class GZip {
  Future<List<int>> compress(Uint8List data) async =>
      gzip.encoder.convert(data);

  Future<List<int>> decompress(Uint8List data) async =>
      gzip.decoder.convert(data);
}
