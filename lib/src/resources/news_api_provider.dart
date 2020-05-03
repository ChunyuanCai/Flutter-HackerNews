import 'package:http/http.dart' show Client;
import 'package:news/src/resources/repository.dart';
import 'dart:convert';
import '../models/item_model.dart';

final _endpoint = "https://hacker-news.firebaseio.com/v0";

class NewsApiProvider implements Source{
  Client client = Client();

  @override
  Future<List<int>> fetchTopIds() async {
    final response = await client.get("$_endpoint/topstories.json");
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get("$_endpoint/item/$id.json");
    return ItemModel.fromJson(json.decode(response.body));
  }
}

final NewsApiProvider newsApiProvider = NewsApiProvider();
