import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:supermarket_sales_prediction_app/components/button.dart';
import 'package:supermarket_sales_prediction_app/components/text_fields.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:supermarket_sales_prediction_app/components/button.dart';
import 'package:supermarket_sales_prediction_app/components/text_fields.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
//Function to call the API

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Text editiong controllers
  final quantityTxtCtrl = TextEditingController();
  final unit_costTxtCtrl = TextEditingController();
  String predictedIncome = '';

  // Function to send POST request to API
  Future<void> predictGrossIncome() async {
    final url = Uri.parse('http://127.0.0.1:5000/api/predict/lr'); // API endpoint
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'unit_cost': unit_costTxtCtrl.text,
        'quantity': quantityTxtCtrl.text,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        predictedIncome = data['gross_income'].toString();
      });
    } else {
      setState(() {
        predictedIncome = 'Error: Unable to predict';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 29.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.online_prediction_rounded,
                    size: 100,),
                  //Title of the app
                  const Text('Gross Income Predictor'),
                  const SizedBox(height: 25),

                  //Input amount to predict
                  MyTextField(
                    controller: quantityTxtCtrl,
                    hintText: 'Enter quantity value',
                    obscure: false,
                  ),
                  const SizedBox(height: 5),
                  MyTextField(
                    controller: unit_costTxtCtrl,
                    hintText: 'Enter unit cost value',
                    obscure: false,
                  ),
                  const SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: predictGrossIncome,
                    child: Text('Predict Gross Income'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Predicted Gross Income: $predictedIncome',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ), //button new
                ],
              ),
            ),
          ),
      ),
    );
  }
}