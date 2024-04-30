import 'dart:io';
import 'dart:typed_data';

class GZip {
  Future<List<int>> compress(Uint8List data) async =>
      gzip.encoder.convert(data);

  Future<List<int>> decompress(Uint8List data) async =>
      gzip.decoder.convert(data);
}
