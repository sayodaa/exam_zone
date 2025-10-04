import 'dart:io';
import 'package:yaml/yaml.dart';

void main() {
  final file = File('pubspec.yaml');
  if (!file.existsSync()) {
    print('❌ pubspec.yaml not found in current directory.');
    return;
  }

  final yamlString = file.readAsStringSync();
  final doc = loadYaml(yamlString);

  final flutterSection = doc['flutter'];
  if (flutterSection == null || flutterSection['assets'] == null) {
    print('⚠️ No assets section found in pubspec.yaml');
    return;
  }

  final assets = List<String>.from(flutterSection['assets']);
  bool allExist = true;

  for (var asset in assets) {
    if (asset.endsWith('/')) {
      // لو مستخدم فولدر كامل
      final dir = Directory(asset);
      if (!dir.existsSync()) {
        print('❌ Missing directory: $asset');
        allExist = false;
      } else {
        print('✅ Found directory: $asset');
      }
    } else {
      final assetFile = File(asset);
      if (!assetFile.existsSync()) {
        print('❌ Missing file: $asset');
        allExist = false;
      } else {
        print('✅ Found file: $asset');
      }
    }
  }

  if (allExist) {
    print('\n🎉 All assets exist and are ready!');
  } else {
    print('\n⚠️ Some assets are missing, please fix above errors.');
  }
}
