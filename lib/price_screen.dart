import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'price_details.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  PriceScreen priceScreen = PriceScreen();

  String selectedCurrency = 'USD';
  List lastprice = [];
  int price1;
  int price2;
  int price3;

  @override
  void initState() {
    getCurrentPrice(selectedCurrency);
    super.initState();
  }

  void getCurrentPrice(String value) async {
    CoinData coindata = CoinData();
    lastprice = await coindata.getCoinData(selectedCurrency);
    setState(() {
      price1 = lastprice[0].toInt();
      price2 = lastprice[1].toInt();
      price3 = lastprice[2].toInt();
    });
    print(lastprice);
  }

  List<DropdownMenuItem> getDropdownItems() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      var newItem = DropdownMenuItem(
        child: Text('${currenciesList[i]}'),
        value: '${currenciesList[i]}',
      );

      dropDownItems.add(newItem);
    }
    return dropDownItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          PriceDetails(
              crypto: 'BTC', price: price1, selectedCurrency: selectedCurrency),
          PriceDetails(
              crypto: 'ETH', price: price2, selectedCurrency: selectedCurrency),
          PriceDetails(
              crypto: 'LTC', price: price3, selectedCurrency: selectedCurrency),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
                value: selectedCurrency,
                items: getDropdownItems(),
                onChanged: (value) {
                  setState(() {
                    selectedCurrency = value;
                    getCurrentPrice(selectedCurrency);
                    price1 = lastprice[0].toInt();
                    price2 = lastprice[1].toInt();
                    price3 = lastprice[2].toInt();
                  });
                }),
          ),
        ],
      ),
    );
  }
}
