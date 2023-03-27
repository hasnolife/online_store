import 'dart:convert';
import 'dart:io';

abstract class ApiClient<T> {
  final _apiClient = HttpClient();


  Future<T> getData(String url) async {
    final uri = Uri.parse(url);
    final request = await _apiClient.getUrl(uri);
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    final data = convertJsonToData(json);
    return data;
  }

  T convertJsonToData(Map<String, dynamic> json);
}
