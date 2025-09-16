// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart';

class GZip {
  Future<List<int>> compress(Uint8List data) async {
    final compressionStream = CompressionStream('gzip');
    final reader =
        _blob(data)
                .stream()
                .pipeThrough(
                  ReadableWritablePair(
                    readable: compressionStream.readable,
                    writable: compressionStream.writable,
                  ),
                )
                .getReader()
            as ReadableStreamDefaultReader;
    return await _readUntilDone(reader);
  }

  Future<List<int>> decompress(Uint8List data) async {
    final decompressionStream = DecompressionStream('gzip');
    final reader =
        _blob(data)
                .stream()
                .pipeThrough(
                  ReadableWritablePair(
                    readable: decompressionStream.readable,
                    writable: decompressionStream.writable,
                  ),
                )
                .getReader()
            as ReadableStreamDefaultReader;
    return await _readUntilDone(reader);
  }

  Future<List<int>> _readUntilDone(ReadableStreamDefaultReader reader) async {
    final values = <int>[];
    var isDone = false;
    while (!isDone) {
      final readChunk = await reader.read().toDart;
      if (readChunk.value != null) {
        final value = readChunk.value as JSUint8Array;
        values.addAll(value.toDart);
      }
      isDone = readChunk.done;
    }
    return values;
  }

  Blob _blob(Uint8List data) =>
      Blob([data.toJS].toJS, BlobPropertyBag(type: 'application/octet-stream'));
}
