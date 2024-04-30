// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

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
