import 'dart:convert';
import 'dart:typed_data';

import 'package:gzip/gzip.dart';
import 'package:test/test.dart';

const dec = Base64Decoder();
const enc = Utf8Encoder();
void main() {
  for (final (:name, :input, :output) in [
    (
      name: 'Simple ASCII',
      input: enc.convert('Hello World'),
      output: dec.convert('H4sIAAAAAAAAA/NIzcnJVwjPL8pJAQBWsRdKCwAAAA=='),
    ),
    (
      name: 'More complex',
      input: enc.convert('éàöñ 漢 こんにちは به متنی©®€£µ¥'),
      output: dec.convert('H4sIAAAAAAAAAwE3AMj/w6nDoMO2w7Eg5ryiIOOBk+OCk+OBq+O'
          'BoeOBryDYqNmHINmF2KrZhtuMwqnCruKCrMKjwrXCpXqkccQ3AAAA'),
    ),
  ]) {
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
