import 'dart:io';
import 'dart:typed_data';

Uint8List switchPlatformBit(List<int> input) {
  const osBit = 9;
  input[osBit] = switch (Platform.operatingSystem) {
    'linux' => 3,
    'macos' => 19,
    'windows' => 10,
    String() => throw UnimplementedError('No id for this platform found'),
  };
  return Uint8List.fromList(input);
}
