import 'dart:convert';
import 'dart:typed_data';

Uint8List decodeBase64Image(String base64Image) {
  return base64Decode(base64Image);
}
