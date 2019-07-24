import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      title: 'Interest calculator',
      debugShowCheckedModeBanner: false,
      home: SIForm(),
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.indigo,
          accentColor: Colors.indigoAccent),
    ));

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SIFormState();
  }
}

class SIFormState extends State<SIForm> {
  var _currency = ['Rupees', 'Dollors', 'Pounds'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentValue = _currency[0];
  }
  var currentValue = '';
  final minPadding = 5.0;
  var displayResult = '';

  var _formKey = GlobalKey<FormState>(); 

  TextEditingController pController = TextEditingController();
  TextEditingController rController = TextEditingController();
  TextEditingController tController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Interest Calculator'),
      ),
      body:Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(minPadding * 2),
        //margin: EdgeInsets.all(minPadding * 2),
        child: ListView(
          children: <Widget>[
            getImageAsset(),
            Padding(
              padding: EdgeInsets.only(top: minPadding, bottom: minPadding),
              child: TextFormField(
                controller: pController,
                 validator: (String value){
                   if (value.isEmpty)
                   {
                     return 'Please Enter Principal Amount';
                   }
                 },
                style: textStyle,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Principal',
                    labelStyle: textStyle,
                    hintText: 'Enter Principal eg.15000',
                    errorStyle: TextStyle(fontSize: 15.0,color: Colors.yellowAccent),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: minPadding, bottom: minPadding),
              child: TextFormField(
                controller: rController,
                validator: (String value){
                  if(value.isEmpty)
                  {
                    return 'Please Enter Rate of Interest';
                  }
                },
                style: textStyle,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Rate of interest',
                    labelStyle: textStyle,
                    hintText: 'Enter Interest Rate eg.8',
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: minPadding, bottom: minPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextFormField(
                      controller: tController,
                      validator: (String value){
                        if(value.isEmpty)
                        {
                          return 'Please Enter Term';
                        }
                      },
                      onFieldSubmitted: (String value){
                        if(value.isEmpty)
                        {
                          
                        }
                      },
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Term',
                          labelStyle: textStyle,
                          hintText: 'In Year',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                    Container(
                      width: minPadding * 5,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        items: _currency.map((String str) {
                          return DropdownMenuItem<String>(
                            value: str,
                            child: Text(str),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            this.currentValue = newValue;
                          });
                        },
                        value: currentValue,
                      ),
                    )
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(top: minPadding, bottom: minPadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColorDark,
                      child: Text(
                        'Calculate',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          if(_formKey.currentState.validate())
                          {
                          this.displayResult = _calculateTotal();
                         }
                        });
                      },
                    ),
                  ),
                  Container(width: minPadding),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Reset',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.all(minPadding * 2),
                child: Center(
                  child: Text(
                    this.displayResult,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ))
          ],
        ),
      )),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/image.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.all(minPadding * 10),
    );
  }

  String _calculateTotal() {
    double principal = double.parse(pController.text);
    double interest = double.parse(rController.text);
    double term = double.parse(tController.text);

    double totalAmount = principal + (principal * interest * term) / 100;

    String result =
        'After $term years, your investment will be worth $totalAmount $currentValue';
    return result;

  }

  void _reset() {
    pController.text = '';
    rController.text = '';
    tController.text = '';
    displayResult = '';
    currentValue = _currency[0];


  }
}
