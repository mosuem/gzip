// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart';

class GZip {
  Future<Uint8List> compress(Uint8List data) async {
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

  Future<Uint8List> decompress(Uint8List data) async {
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

  Future<Uint8List> _readUntilDone(ReadableStreamDefaultReader reader) async {
    final builder = BytesBuilder(copy: false);

    var isDone = false;
    while (!isDone) {
      final readChunk = await reader.read().toDart;
      final uint8Array = readChunk.value as JSUint8Array?;

      if (uint8Array != null) {
        builder.add(uint8Array.toDart);
      }
      isDone = readChunk.done;
    }

    return builder.takeBytes();
  }

  Blob _blob(Uint8List data) =>
      Blob([data.toJS].toJS, BlobPropertyBag(type: 'application/octet-stream'));
}
