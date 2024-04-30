import 'dart:js_interop';
import 'dart:typed_data';

import 'package:web/web.dart';

class GZip {
  final compressionStream = CompressionStream('gzip');
  final decompressionStream = DecompressionStream('gzip');

  Future<List<int>> compress(Uint8List data) async {
    final reader = _blob(data)
        .stream()
        .pipeThrough(ReadableWritablePair(
          readable: compressionStream.readable,
          writable: compressionStream.writable,
        ))
        .getReader() as ReadableStreamDefaultReader;
    return await _readUntilDone(reader);
  }

  Future<List<int>> decompress(Uint8List data) async {
    final reader = _blob(data)
        .stream()
        .pipeThrough(ReadableWritablePair(
          readable: decompressionStream.readable,
          writable: decompressionStream.writable,
        ))
        .getReader() as ReadableStreamDefaultReader;
    return await _readUntilDone(reader);
  }

  Future<List<int>> _readUntilDone(ReadableStreamDefaultReader reader) async {
    final values = <int>[];
    var isDone = false;
    while (!isDone) {
      final readChunk = await reader.read().toDart;
      if (readChunk.value != null) {
        values.addAll(readChunk.value as Uint8List);
      }
      isDone = readChunk.done;
    }
    return values;
  }

  Blob _blob(Uint8List data) => Blob(
        [data.toJS].toJS,
        BlobPropertyBag(type: 'application/octet-stream'),
      );
}
