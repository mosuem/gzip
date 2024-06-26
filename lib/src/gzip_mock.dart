// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:typed_data';

/// The [GZip] encodes raw bytes to GZip compressed bytes and decodes GZip
/// compressed bytes to raw bytes.
///
/// It is implemented using `dart:io` on native platforms and `package:web` in
/// browsers.
class GZip {
  /// Compress the [data] using gzip compression.
  Future<List<int>> compress(Uint8List data) async =>
      throw UnimplementedError();

  /// Decode the gzip-compressed [data].
  Future<List<int>> decompress(Uint8List data) async =>
      throw UnimplementedError();
}
