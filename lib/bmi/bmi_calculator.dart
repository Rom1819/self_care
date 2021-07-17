import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constrains.dart';

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  int currentIndex = 0;
  double height = 0;
  double weight = 0;
  String result = "";
  String category = "";

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'BMI Calculator',
          style: TextStyle(
              fontSize: 22, color: textColor, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/back.svg",
            color: textColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      radioButton("Man", backgroundColor, 0),
                      radioButton("Woman", Colors.pink, 1),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'Enter you height in Cm :',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: heightController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Enter you height in Cm',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'Enter you weight in Kg :',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: weightController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Enter you weight in Kg',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Your BMI : ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22.0,
                              color: textColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(defaultPadding / 2),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Text(
                              '$result',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 28.0,
                                  color: backgroundColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'BMI Status : ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22.0,
                              color: textColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(defaultPadding / 2),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Text(
                              '$category',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24.0,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50.0,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          height = double.parse(heightController.value.text);
                          weight = double.parse(weightController.value.text);
                          calculateBMI(height, weight);
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 8.0,
                      color: Colors.white,
                      textColor: backgroundColor,
                      child: Text(
                        'Calculate',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void calculateBMI(double height, double weight) {
    double finalResult = weight / pow((height / 100), 2);
    String bmi = finalResult.toStringAsFixed(2);
    setState(() {
      result = bmi;

      if (finalResult <= 16.0) {
        category = "Severely Underweight";
      } else if (finalResult >= 16.0 && finalResult < 18.5) {
        category = "Underweight";
      } else if (finalResult >= 18.5 && finalResult < 25.0) {
        category = "Normal";
      } else if (finalResult >= 25.0 && finalResult < 30.0) {
        category = "Overweight";
      } else if (finalResult >= 30.0 && finalResult < 35.0) {
        category = "Obese";
      } else if (finalResult >= 35.0 && finalResult < 40.0) {
        category = "Severely Obese";
      } else {
        category = "Extremely Obese";
      }
    });
  }

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget radioButton(String value, Color color, int index) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      height: 70.0,
      // ignore: deprecated_member_use
      child: FlatButton(
          child: Text(
            value,
            style: TextStyle(
              color: currentIndex == index ? Colors.white : color,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          color: currentIndex == index ? color : Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          onPressed: () {
            changeIndex(index);
            heightController.clear();
            weightController.clear();
            result = "";
            category = "";
          }),
    ));
  }
}
