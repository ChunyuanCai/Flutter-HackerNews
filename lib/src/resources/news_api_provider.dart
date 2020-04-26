import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';

final _endpoint = "https://hacker-news.firebaseio.com/v0";

class NewsApiProvider {
  Client client = Client();

  fetchTopIds() async {
    final response = await client.get("$_endpoint/topstories.json");
    return json.decode(response.body);
  }

  fetchItem(int id) async {
    final response = await client.get("$_endpoint/item/$id.json");
    return ItemModel.fromJson(json.decode(response.body));
  }
}
