import 'package:flutter/material.dart';
import 'dart:math';

class MortgageApp extends StatefulWidget {
  const MortgageApp({super.key});

  @override
  _MortgageAppState createState() => _MortgageAppState();
}

class _MortgageAppState extends State<MortgageApp> {
  double _interest = 0.0;
  int _lengthOfLoan = 0;
  double _homePrice = 0.0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: const Text("Mortgage Payments"),
       ),
    body: Container(
       alignment: Alignment.center,
      child: ListView(
          scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(
            height: 130,
             child: Card(
                elevation: 5,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                      const Text("Monthly Payment"),
                      const SizedBox(height: 9),
                    Text(" ${ ( _homePrice > 0 && _interest > 0.0) ? "\$${calculateMonthlyPayment(_homePrice, _interest, _lengthOfLoan)}" : ""}")
                  ],
               ),
             ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 20),
             decoration: BoxDecoration(
               color: Colors.transparent,
               border: Border.all(
                  color: Colors.blueGrey.shade100, //TODO: theme this!
                 style: BorderStyle.solid// //TODO: theme this!
               ),
               borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                 children: <Widget>[
                    TextField(
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(color: Colors.black),//TODO: theme this!
                      decoration: const InputDecoration(
                        hintText: "Home Price",
                         prefixIcon: Icon(Icons.home)),
                      onChanged: (String value) {
                        try {
                          _homePrice = double.parse(value);

                        }catch (exception) {
                           _homePrice = 0.0;
                        }

                      },//TODO: theme this!
                    ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       const Text("Length of Loan (years)"), //TODO: Theme this!

                       Row(
                         children: <Widget>[
                           InkWell(
                             onTap: () {
                               setState(() {
                                 if(_lengthOfLoan > 0) {
                                   _lengthOfLoan -= 5;
                                 }else {
                                   // do nothing
                                 }
                               });
                             },
                             child: Container(
                               width: 40,
                               height: 40,
                               margin: const EdgeInsets.all(10),
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(16),
                                   color: Colors.blueGrey.withOpacity(0.2)
                               ),
                               child: const Center(child: Text("-")), //TODO: Style Theme it!
                             ),
                           ),
                           Text("$_lengthOfLoan"), //TODO: Style Theme it!
                           InkWell(
                               onTap: () {
                                  setState(() {

                                     _lengthOfLoan += 5;
                                  });
                               },
                             child: Container(
                                width: 40,
                               height: 40,
                               margin: const EdgeInsets.all(10),
                               decoration: BoxDecoration(
                                   color: Colors.blueGrey.withOpacity(0.2),
                                 borderRadius: BorderRadius.circular(16)
                               ),
                               child: const Center(child:Text("+")) //TODO: theme this!

                             ),
                           )
                         ],
                       )
                     ],
                   ),

                   //Interest
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                        const Text("Interest"), ////TODO: theme this!
                       Padding(padding: const EdgeInsets.all(18), child:Text("${_interest.toStringAsFixed(2)} %") )
                     ],
                   ),

                   //Slider
                   Column(
                      children: <Widget>[
                        Slider(
                            min: 0.0,
                            max: 10.0,
                            activeColor: Colors.red , //TODO: Theme this!
                            inactiveColor: Colors.grey, //TODO: Theme this!
                           // divisions: 10,
                            value: _interest,
                            onChanged: (double newValue) {
                                  setState(() {

                                     _interest = newValue;
                                  });
                            })
                      ],
                   )

                 ],
              ),
            ),
          )
          
          
        ],
      ),
    ),
    );
    
  }

  //Monthly Payment Formula
  /*
   n = number of payments
   c = monthly interest rate

   int n = 12 * years;
   double c = rate / 12.0 / 100.0;
   double payment = loan * c * Math.pow(1 + c, n) /
                    (Math.pow(1 + c, n) - 1);
   */
   calculateMonthlyPayment(double homePrice, double interest, int loanLength ) {
     int n = 12 * loanLength;
     double c = interest / 12.0 / 100.0;
     double monthlyPayment = 0.0;

     if (homePrice < 0 || homePrice.toString().isEmpty || homePrice == null) {
        //no go!
      // _homePrice = 0.0;
     }else {
       monthlyPayment = homePrice * c * pow(1 + c, n) / (pow(1 + c, n) - 1);
     }


     return monthlyPayment.toStringAsFixed(2);
  }
}
