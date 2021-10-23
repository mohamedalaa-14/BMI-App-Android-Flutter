import 'dart:math';
import 'result.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isMale = true;
  double heightVal = 170;

  int weight = 55;
  int age = 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Body Mass Index"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    buildm1Expanded(context, "male"),
                    SizedBox(width: 15),
                    buildm1Expanded(context, "female"),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: Colors.blueGrey),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center ,
                    children: [
                      Text("Height",style: Theme.of(context).textTheme.headline2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:CrossAxisAlignment.baseline ,
                        textBaseline: TextBaseline.alphabetic ,
                        children: [
                          Text(heightVal.toStringAsFixed(1),style: Theme.of(context).textTheme.headline1,),
                          Text("CM",style: Theme.of(context).textTheme.bodyText1,),
                        ],
                      ),
                      Slider(
                        min: 90,
                        max: 220,
                        value: heightVal,
                        onChanged: (newvalue) {
                          setState(() {
                            heightVal=newvalue;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    buildm2Expanded(context, "weight"),
                    SizedBox(width: 15),
                    buildm2Expanded(context, "age"),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.teal,
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 16,
              child: TextButton(
                  onPressed: () {
                    var result = weight / pow(heightVal / 100, 2);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Result(result: result, isMale: isMale, age: age);
                    }));
                  },
                  child: Text(
                    "Calculate",
                    style: Theme.of(context).textTheme.headline2,
                  )),
            )
          ],
        ),
      ),
    );
  }

  Expanded buildm1Expanded(BuildContext context, String type) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isMale = type == "male" ? true : false;
          });
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: (isMale && type == "male") || (!isMale && type == "female")
                  ? Colors.teal
                  : Colors.blueGrey),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                type == "male" ? Icons.male : Icons.female,
                size: 90,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                type == "male" ? "Male" : "Female",
                style: Theme.of(context).textTheme.headline2,
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildm2Expanded(BuildContext context, String type) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.blueGrey),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              type == "age" ? "Age" : "Weight",
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              type == "age" ? "$age" : "$weight",
              style: Theme.of(context).textTheme.headline1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: type == "age" ? "age--" : "weight--",
                  child: Icon(Icons.remove),
                  mini: true,
                  onPressed: () {
                    setState(() {
                      type == "age" ? age-- : weight--;
                    });
                  },
                ),
                SizedBox(
                  width: 8,
                ),
                FloatingActionButton(
                  heroTag: type == "age" ? "age++" : "weight++",
                  child: Icon(Icons.add),
                  mini: true,
                  onPressed: () {
                    setState(() {
                      type == "age" ? age++ : weight++;
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
