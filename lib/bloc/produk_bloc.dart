import 'dart:convert';
import '../helpers/api.dart';
import '../helpers/api_url.dart';
import '../model/produk.dart';

class ProdukBloc {
  static Future<List<Produk>> getProduks() async {
    String apiUrl = ApiUrl.listProduk;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List list = jsonObj['data'];

    return list.map((item) => Produk.fromJson(item)).toList();
  }

  static Future addProduk({required Produk produk}) async {
    String apiUrl = ApiUrl.createProduk;

    var body = produk.toJson();

    var response = await Api().post(apiUrl, body);
    return json.decode(response.body)['status'];
  }

  static Future updateProduk({required Produk produk}) async {
    String apiUrl = ApiUrl.updateProduk(int.parse(produk.id!));

    var body = {
      "_method": "PUT",  // ← FIX PENTING
      ...produk.toJson(),
    };

    var response = await Api().post(apiUrl, body);
    return json.decode(response.body)['status'];
  }

  static Future<bool> deleteProduk({int? id}) async {
    String apiUrl = ApiUrl.deleteProduk(id!);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);

    return jsonObj['data'];
  }
}