import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../../Api Helper/Repository/api_client.dart';


Future<String> fileFromImageUrl(imageURL,name) async {
  final response = await http.get(Uri.parse(ApiClient.imageBasePath+imageURL));
  final documentDirectory = await getApplicationDocumentsDirectory();
  final file = File(join(documentDirectory.path, name));
  file.writeAsBytesSync(response.bodyBytes);
  return file.path;
}