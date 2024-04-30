// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

export 'src/gzip_mock.dart'
    if (dart.library.io) 'src/gzip_io.dart'
    if (dart.library.js_interop) 'src/gzip_web.dart';
