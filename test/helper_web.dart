// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:typed_data';

import 'package:os_detect/os_detect.dart';

Uint8List switchPlatformBit(List<int> input) {
  const osBit = 9;
  if (operatingSystemVersion.contains('linux')) {
    input[osBit] = 3;
  } else if (operatingSystemVersion.contains('macos')) {
    input[osBit] = 19;
  } else if (operatingSystemVersion.contains('windows')) {
    input[osBit] = 10;
  } else {
    throw UnimplementedError(
      'No OS bit for platform $operatingSystemVersion found',
    );
  }
  return Uint8List.fromList(input);
}
