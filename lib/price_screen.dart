import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
// import 'dart:io' show Platform;

import 'services/network.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  String bitcoin = "BTC";
  String ethereum = "ETH";
  String litecoin = "LTC";

  double pricebtc = 00000;
  double priceeth = 00000;
  double pricelitecoin = 00000;
  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getdata(bitcoin);
          getdata(ethereum);
          getdata(litecoin);
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getdata(bitcoin);
          getdata(ethereum);
          getdata(litecoin);
        });

        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  //TODO: Create a method here called getData() to get the coin data from coin_data.dart
  Future getdata(String crypto) async {
    NetworkModel networkModel = NetworkModel(
        url:
            "https://apiv2.bitcoinaverage.com/indices/global/ticker/$crypto$selectedCurrency");
    var data = await networkModel.getData();
    double priceapi = data["last"];
    setState(() {
      if (crypto == bitcoin) {
        if (priceapi != null) {
          pricebtc = priceapi;
        } else {
          pricebtc = 0000;
        }
      } else if (crypto == ethereum) {
        if (priceapi != null) {
          priceeth = priceapi;
        } else {
          priceeth = 0000;
        }
      } else {
        if (priceapi != null) {
          pricelitecoin = priceapi;
        } else {
          pricelitecoin = 0000;
        }
      }
    });
    print(pricebtc);
    print(priceeth);
    print(pricelitecoin);
  }

  @override
  void initState() {
    super.initState();
    getdata(bitcoin);
    getdata(ethereum);
    getdata(litecoin);
    //TODO: Call getData() when the screen loads up.
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
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  //TODO: Update the Text Widget with the live bitcoin data here.
                  '1 BTC = $pricebtc $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  //TODO: Update the Text Widget with the live bitcoin data here.
                  '1 Ethreum = $priceeth $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  //TODO: Update the Text Widget with the live bitcoin data here.
                  '1 Litecoin = $pricelitecoin $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: iOSPicker(),
          ),
        ],
      ),
    );
  }
}
// Platform.isIOS ? iOSPicker() : androidDropdown()
