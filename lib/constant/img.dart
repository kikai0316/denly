import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

DecorationImage assetImg(String file) {
  return DecorationImage(
    image: AssetImage("assets/img/$file"),
    fit: BoxFit.cover,
  );
}

DecorationImage networkImg(String url) {
  return DecorationImage(
    image: NetworkImage(url),
    fit: BoxFit.cover,
  );
}

DecorationImage memoryImg(Uint8List memory) {
  return DecorationImage(
    image: MemoryImage(memory),
    fit: BoxFit.cover,
  );
}

DecorationImage fileImg(File fileData) {
  return DecorationImage(
    image: FileImage(fileData),
    fit: BoxFit.cover,
  );
}

String? notImg(String? img) {
  return img == null ? "not.png" : null;
}
