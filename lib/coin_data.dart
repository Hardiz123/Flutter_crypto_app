import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<List> getCoinData(String countryName) async {
    List responses = [];
    String Name;
    Name = countryName;
    String startURL = 'https://rest.coinapi.io/v1/exchangerate';
    String apiKey = 'DABE09D5-B637-458B-8C75-3877A03FDACF';

    var url1 = '$startURL/BTC/$Name?apikey=$apiKey';
    var url2 = '$startURL/ETH/$Name?apikey=$apiKey';
    var url3 = '$startURL/LTC/$Name?apikey=$apiKey';

    http.Response response1 = await http.get(url1);
    http.Response response2 = await http.get(url2);
    http.Response response3 = await http.get(url3);

    if (response1.statusCode == 200 &&
        response2.statusCode == 200 &&
        response3.statusCode == 200) {
      var decodeData1 = jsonDecode(response1.body);
      var decodeData2 = jsonDecode(response2.body);
      var decodeData3 = jsonDecode(response3.body);

      var lastPrice1 = decodeData1['rate'];
      var lastPrice2 = decodeData2['rate'];
      var lastPrice3 = decodeData3['rate'];
      responses.add(lastPrice1);
      responses.add(lastPrice2);
      responses.add(lastPrice3);
      return responses;
    } else {
      print(response1.statusCode);
    }
  }
}
