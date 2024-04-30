import 'dart:convert';
import 'dart:typed_data';

import 'package:gzip/gzip.dart';
import 'package:test/test.dart';

import 'helper_mock.dart'
    if (dart.library.io) 'helper_io.dart'
    if (dart.library.js_interop) 'helper_web.dart';

const enc = Utf8Encoder();
void main() {
  for (final (:name, :input, output: outputList) in cases) {
    final output = switchPlatformBit(outputList);
    test(
      'Compress $name',
      () async => expect(await GZip().compress(input), output),
    );
    test(
      'Decompress $name',
      () async => expect(await GZip().decompress(output), input),
    );
    test(
      'Roundtrip $name',
      () async {
        final compressed = await GZip().compress(input);
        expect(await GZip().decompress(Uint8List.fromList(compressed)), input);
      },
    );
    test(
      'Roundtrip back $name',
      () async {
        final decompressed = await GZip().decompress(output);
        expect(await GZip().compress(Uint8List.fromList(decompressed)), output);
      },
    );
  }
}

final cases = [
  (
    name: 'Simple ASCII',
    input: enc.convert('Hello World'),
    output: [
      31,
      139,
      8,
      0,
      0,
      0,
      0,
      0,
      0,
      3,
      243,
      72,
      205,
      201,
      201,
      87,
      8,
      207,
      47,
      202,
      73,
      1,
      0,
      86,
      177,
      23,
      74,
      11,
      0,
      0,
      0
    ],
  ),
  (
    name: 'More complex',
    input: enc.convert('éàöñ 漢 こんにちは به متنی©®€£µ¥'),
    output: [
      31,
      139,
      8,
      0,
      0,
      0,
      0,
      0,
      0,
      3,
      1,
      55,
      0,
      200,
      255,
      195,
      169,
      195,
      160,
      195,
      182,
      195,
      177,
      32,
      230,
      188,
      162,
      32,
      227,
      129,
      147,
      227,
      130,
      147,
      227,
      129,
      171,
      227,
      129,
      161,
      227,
      129,
      175,
      32,
      216,
      168,
      217,
      135,
      32,
      217,
      133,
      216,
      170,
      217,
      134,
      219,
      140,
      194,
      169,
      194,
      174,
      226,
      130,
      172,
      194,
      163,
      194,
      181,
      194,
      165,
      122,
      164,
      113,
      196,
      55,
      0,
      0,
      0
    ],
  ),
];
