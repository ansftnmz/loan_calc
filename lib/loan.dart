import 'dart:math';

import 'package:flutter/material.dart';

class LoanScreen extends StatelessWidget {
  const LoanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loan Calculator App',
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 235, 225, 196),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 203, 176, 94),
          title: const Text('Loan Calculator'),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
                height: 150,
                child: Center(
                  child: Image.asset('assets/images/logo.png'),
                )),
            const LoanForm(),
          ]),
        ),
      ),
    );
  }
}

class LoanForm extends StatefulWidget {
  const LoanForm({Key? key}) : super(key: key);

  @override
  State<LoanForm> createState() => _LoanFormState();
}

class _LoanFormState extends State<LoanForm> {
  TextEditingController loanAmtEditingController = TextEditingController();
  TextEditingController monthsEditingController = TextEditingController();
  TextEditingController interestAmtEditingController = TextEditingController();
  double loanAmt = 0.0,
      months = 0,
      interestAmt = 0.0,
      total = 0.0,
      convertedAmtOfInterest = 0.0;
  num exponent = 0.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            "Loan Calculator",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: loanAmtEditingController,
            keyboardType: const TextInputType.numberWithOptions(),
            decoration: InputDecoration(
                hintText: "Loan Amount (RM) ",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: monthsEditingController,
            keyboardType: const TextInputType.numberWithOptions(),
            decoration: InputDecoration(
                hintText: "Loan Term (in months)",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: interestAmtEditingController,
            keyboardType: const TextInputType.numberWithOptions(),
            decoration: InputDecoration(
                hintText: "Interest Rate(%)",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _loanCalc,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.amber,
              backgroundColor: Colors.black, // Text Color (Foreground color)
            ),
            child: const Text(
              'Calculate Loan',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Monthly Payment RM ${total.toStringAsPrecision(6)}",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _loanCalc() {
    loanAmt = double.parse(loanAmtEditingController.text);
    months = double.parse(monthsEditingController.text);
    interestAmt = double.parse(interestAmtEditingController.text);
    convertedAmtOfInterest = interestAmt / (12 * 100);
    exponent = pow((1 + convertedAmtOfInterest), months);
    setState(() {
      total = (loanAmt * convertedAmtOfInterest * exponent) / (exponent - 1);
      
    });
  }
}
