import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';

final _endpoint = "https://hacker-news.firebaseio.com/v0";

class NewsApiProvider {
  Client client = Client();

  fetchTopIds() async {
    final response = await client.get("$_endpoint/topstories.json");
    final ids = json.decode(response.body);
    return ids;
  }

  fetchItem(int id) async {
    final response = await client.get("$_endpoint/item/$id.json");
    final parsedJson = json.decode(response.body);
    return ItemModel.fromJson(parsedJson);
  }
}
