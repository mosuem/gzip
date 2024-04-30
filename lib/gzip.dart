export 'src/gzip_mock.dart'
    if (dart.library.io) 'src/gzip_io.dart'
    if (dart.library.js_interop) 'src/gzip_web.dart';
