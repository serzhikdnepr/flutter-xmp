# Flutter XMP

A Flutter library to deal with Images XMP data extraction using native implementation for both Android and iOS.

[![pub package](https://img.shields.io/badge/pub-0.0.1-blue)](https://pub.dev/packages/flutter_xmp)

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

Obs: For now the package works only with remote images. 

## Screeshots

![Android Screenshot](https://user-images.githubusercontent.com/35772322/122821699-89ee3200-d2b3-11eb-8c29-27d19bf6fdcf.png)

![iOS Screenshot](https://user-images.githubusercontent.com/35772322/122821711-8eb2e600-d2b3-11eb-958b-09f89ff7c062.png)


## Next steps:

- [x] Extract XMP info from remote images
- [ ] Extract XMP info from local images
  
