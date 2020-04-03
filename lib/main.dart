import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest Calculator App",
    home: SIForm(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SIFormState();
  }
}

class SIFormState extends State<SIForm> {
  var formKey = GlobalKey<FormState>();
  final minimum_padding = 5.0;
  var _currencies = ["Rupees", "Dollars", "Pounds"];
  var _currentItemSelected = "";

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var displayResult = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(minimum_padding * 2),
          child: ListView(
            children: <Widget>[
              getImageAsset(),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimum_padding, bottom: minimum_padding),
                  child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: principalController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Principal amount field cannot be EMPTY!";
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Principal",
                          hintText: "Enter Principal Amount e.g 10000",
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                              color: Colors.yellowAccent, fontSize: 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0))))),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimum_padding, bottom: minimum_padding),
                  child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: roiController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Rate of Interest field cannot be EMPTY!";
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Rate of Interest",
                          hintText: "In Percent",
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                              color: Colors.yellowAccent, fontSize: 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0))))),
              Padding(
                padding: EdgeInsets.only(
                    top: minimum_padding, bottom: minimum_padding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextFormField(
                            controller: termController,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Term cannot be EMPTY!";
                              }
                            },
                            keyboardType: TextInputType.number,
                            style: textStyle,
                            decoration: InputDecoration(
                                labelText: "Term",
                                hintText: "Time in Years",
                                labelStyle: textStyle,
                                errorStyle: TextStyle(
                                    color: Colors.yellowAccent, fontSize: 15.0),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(6.0))))),
                    Container(
                      width: minimum_padding * 5,
                    ),
                    Expanded(
                        child: DropdownButton<String>(
                      items: _currencies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _currentItemSelected,
                      onChanged: (String newValueSelected) {
                        onDropDownItemSelected(newValueSelected);
                      },
                    ))
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimum_padding, bottom: minimum_padding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text(
                          "Calculate",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            if (formKey.currentState.validate()) {
                              this.displayResult = calculateTotalReturns();
                            }
                          });
                        },
                      )),
                      Expanded(
                          child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          "Reset",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            reset();
                          });
                        },
                      ))
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.all(minimum_padding * 2),
                  child: Text(
                    displayResult,
                    style: textStyle,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage("images/money.png");
    Image image = Image(image: assetImage, width: 125.0, height: 125.0);

    return Container(
        child: image, margin: EdgeInsets.all(minimum_padding * 10));
  }

  void onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  String calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double total = principal + (principal * roi * term) / 100;
    String result =
        'After $term years, your investment will be worth $total $_currentItemSelected';
    return result;
  }

  void reset() {
    principalController.text = "";
    roiController.text = "";
    termController.text = "";
    displayResult = "";
    _currentItemSelected = _currencies[0];
  }
}
