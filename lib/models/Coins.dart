import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

main(){

  getCoins();

}
class Coin {
  final String name;
  final String symbol;
  final String rank;
  final String priceUSD;
  final  String weakpntchange;
  final  String hrpntchange;
  final  String daypntchange;

  Coin.fromJson(Map jsonMap):
        name = jsonMap['name'],
        symbol = jsonMap['symbol'],
        rank = jsonMap['rank'],
        priceUSD = jsonMap['price_usd'],
        hrpntchange = jsonMap['percent_change_1h'],
        daypntchange = jsonMap['percent_change_24h'],
        weakpntchange = jsonMap['percent_change_7d']
  ;

  String toString() => 'Coin: $name $symbol $weakpntchange';
}
Future<Stream<Coin>> getCoins() async {
  var url = 'https://api.coinmarketcap.com/v1/ticker/';

  /* http.get(url).then(
      (res) => print(res.body)
  );*/

  var client = new http.Client();
  var streamedRes = await client.send(
      new http.Request('get', Uri.parse(url))
  );

  return streamedRes.stream
      .transform(UTF8.decoder)
      .transform(JSON.decoder)
      .expand((jsonBody) => (jsonBody as List) )
      .map((jsonCoin) => new Coin.fromJson(jsonCoin));
  //  .listen( (data) => print(data))
  //   .onDone( () => client.close());
}