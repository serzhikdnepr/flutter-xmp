# Flutter XMP

A Flutter library to deal with Images XMP data extraction using native implementation for both Android and iOS.

## Getting Started

```yaml
dependencies:
  flutter_xmp: ^0.0.1
```

Import the package:

```dart
import 'package:flutter_xmp/flutter_xmp.dart';
```

Use the `extractXMPFrom` static method and you're done!

```dart
Map<String, dynamic> xmpData = await FlutterXmp.extractXMPFrom(url: "https://images.com/my-awesome-image.jpg");
```

Obs: For now the package only works with remote images. 

## Next steps:

- [x] Extract XMP info from remote images
- [ ] Extract XMP info from local images
  
