// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:typed_data';

import 'package:gzip/gzip.dart';
import 'package:test/test.dart';

const enc = Utf8Encoder();
void main() {
  for (final (:name, :input, :output) in cases) {
    test(
      'Compress $name',
      () async => exepctUpToPlatform(await GZip().compress(input), output),
    );
    test(
      'Decompress $name',
      () async => exepctUpToPlatform(await GZip().decompress(output), input),
    );
    test('Roundtrip $name', () async {
      final compressed = await GZip().compress(input);
      exepctUpToPlatform(
        await GZip().decompress(Uint8List.fromList(compressed)),
        input,
      );
    });
    test('Roundtrip back $name', () async {
      final decompressed = await GZip().decompress(output);
      final actual = await GZip().compress(Uint8List.fromList(decompressed));
      exepctUpToPlatform(actual, output);
    });
  }
}

void exepctUpToPlatform(List<int> actual, Uint8List output) {
  expect(toFantasyPlatformBit(actual), toFantasyPlatformBit(output));
}

final cases = [
  (
    name: 'Simple ASCII',
    input: enc.convert('Hello World'),
    output: Uint8List.fromList([
      31,
      139,
      8,
      0,
      0,
      0,
      0,
      0,
      0,
      42,
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
      0,
    ]),
  ),
  (
    name: 'More complex',
    input: enc.convert('éàöñ 漢 こんにちは به متنی©®€£µ¥'),
    output: Uint8List.fromList([
      31,
      139,
      8,
      0,
      0,
      0,
      0,
      0,
      0,
      42,
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
      0,
    ]),
  ),
];

Uint8List toFantasyPlatformBit(List<int> input) {
  const osBit = 9;
  input[osBit] = 42;
  return Uint8List.fromList(input);
}
