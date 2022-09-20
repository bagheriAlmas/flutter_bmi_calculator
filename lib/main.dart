import 'package:flutter/material.dart';
import 'package:height_slider/height_slider.dart';
import 'package:horizontal_picker/horizontal_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Horizontal Picker',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // IconData myIcon = Icons.female;
  double height = 170;
  double weight = 90;
  bool gender = true;
  int age = 20;

  double resultValue = 0;

  String personSVG = "assets/images/person.svg";

  String resultMessage = "";
  String resultSuggestion = "";

  bool btnVisible= true;

  var x = ["سانتی‌متر", "پوند"];
  TextStyle txtHintStyle = const TextStyle(
      color: Colors.black26, fontFamily: 'casabelanca', fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              header(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      cardAge(),
                      cardGender(),
                      cardWeight(),
                      //cardSpeedometer()
                    ],
                  ),
                  cardHeight()
                ],
              ),

              //cardHeight(),
              //cardSpeedometer(),
              showResultButton(),
            ],
          ),
        ),
      ),
    );
  }

//------------------------------------------------ Height
  Card cardHeight() {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          generateHintText("قد"),
          SizedBox(
            width: 180,
            height: 385,
            child: HeightSlider(
              personImagePath: personSVG,
              maxHeight: 200,
              height: height.toInt(),
              onChange: (val) => setState(() => height = val.toDouble()),
              unit: 'cm',
            ),
          ),
        ],
      ),
    );
  }

//------------------------------------------------ Gender
  Card cardGender() {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          generateHintText("جنسیت"),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SlidingSwitch(
              value: gender,
              width: 170,
              onChanged: (bool value) {
                setState(() {
                  if (value) {
                    personSVG = "assets/images/person.svg";
                    gender = true;
                  } else {
                    gender = false;
                    personSVG = "assets/images/woman.svg";
                  }
                  value = !value;

                });
              },
              height: 55,
              // animationDuration: const Duration(milliseconds: 250),
              onTap: () {},
              onDoubleTap: () {},
              onSwipe: () {},
              contentSize: 14,
              textOff: "خانم",
              textOn: "آقا",
              colorOn: const Color(0xff6682c0),
              colorOff: const Color(0xffdc6c73),
              background: const Color(0xffe4e5eb),
              buttonColor: const Color(0xfff7f5f7),
              inactiveColor: const Color(0xff636f7b),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

//------------------------------------------------ Weight
  Widget cardWeight() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            generateHintText("وزن"),
            SizedBox(
              width: 190,
              height: 90,
              child: HorizontalPicker(
                minValue: 20,
                maxValue: 160,
                divisions: 140,
                height: weight,
                showCursor: false,
                onChanged: (value) {
                  setState(() {
                    weight = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

//------------------------------------------------ Age
  Widget cardAge() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SizedBox(
          width: 190,
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              generateHintText("سن"),
              Center(
                child: NumberPicker(
                  itemHeight: 40,
                  decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      //   color: Colors.green,
                      // border: Border.all(color: Colors.black, width: 0.0),
                      borderRadius:
                          const BorderRadius.all(Radius.elliptical(100, 100)),
                      boxShadow: const [BoxShadow(color: Color(0x20765392))],
                      border: Border.all(color: Colors.grey)),
                  value: age,
                  minValue: 10,
                  maxValue: 100,
                  onChanged: (value) => setState(() => age = value),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//------------------------------------------------ Speedometer
  Widget cardSpeedometer() {
    double size = 25;
    double rangeOffset = -15;
    GaugeTextStyle labelStyle = const GaugeTextStyle(color: Colors.black54,fontFamily: 'koodak',);

    return SizedBox(
      width: 180,
      height: 180,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(minimum: 0, maximum: 50.1, ranges: <GaugeRange>[
            GaugeRange(
                startValue: 0,
                endValue: 18.5,
                label: "لاغر",
                labelStyle: labelStyle,
                startWidth: size,
                endWidth: size,
                rangeOffset: rangeOffset,
                gradient: const SweepGradient(colors: [
                  Colors.blue,
                  Colors.lightBlueAccent,
                  Colors.greenAccent,
                  Colors.lightGreenAccent,
                ])),
            GaugeRange(
                startValue: 16.5,
                endValue: 30,
                gradient:
                    const SweepGradient(tileMode: TileMode.mirror, colors: [
                  Colors.lightGreenAccent,
                  Colors.green,
                  Colors.yellow,
                ]),
                label: "ایده آل",
                labelStyle: labelStyle,
                startWidth: size,
                endWidth: size,
                rangeOffset: rangeOffset),
            GaugeRange(
                startValue: 27,
                endValue: 35,
                gradient: const SweepGradient(colors: [
                  Colors.yellow,
                  Colors.amberAccent,
                  Colors.amber,
                  Colors.orange,
                ]),
                label: "اضافه وزن",
                labelStyle: labelStyle,
                startWidth: size,
                endWidth: size,
                rangeOffset: rangeOffset),
            GaugeRange(
                startValue: 35,
                endValue: 50.1,
                gradient: const SweepGradient(colors: [
                  Colors.orange,
                  Colors.deepOrange,
                  Colors.redAccent,
                  Colors.red,
                ]),
                label: "چاق",
                labelStyle: labelStyle,
                startWidth: size,
                endWidth: size,
                rangeOffset: rangeOffset),
          ], pointers: <GaugePointer>[
            NeedlePointer(
              value: resultValue,
              needleStartWidth: 1,
              needleEndWidth: 5,
              enableAnimation: true,
            )
          ], annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                widget: Text(resultValue.toStringAsFixed(1),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                angle: 90,
                positionFactor: 0.5)
          ])
        ]),
      ),
    );
  }

//------------------------------------------------ Header
  Widget header() {
    TextStyle txtStyle = const TextStyle(fontSize: 14, fontFamily: 'koodak');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Ink(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            border: Border.all(color: const Color(0xffdddddd)),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(1, 5), // Shadow position
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: SizedBox(
          width: 400,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "سن : ${age.toInt()}",
                style: txtStyle,
              ),
              const VerticalDivider(),
              Text(
                "وزن : ${weight.toInt()}",
                style: txtStyle,
              ),
              const VerticalDivider(),
              Text(
                "قد : ${height.toInt()}",
                style: txtStyle,
              ),
              const VerticalDivider(),
              Text(
                "جنسیت : ${gender ? "آقا" : "خانم"}",
                style: txtStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

//------------------------------------------------ Button Show Result
  Widget showResultButton() {
    calculateBMI();
    return SizedBox(
        width: 400,
        child: OutlinedButton(
          onPressed: () {
            setState(() {
              if(resultValue <= 18.4){
                resultMessage = "لاغر";
                resultSuggestion = "غذا بیشتر بخور";
                btnVisible = true;
              } else if(resultValue >= 18.5 && resultValue <=24.9){
                resultMessage = "ایده عال";
                resultSuggestion = "همینجوری سالم زندگی کن";
                btnVisible = false;
              } else if(resultValue > 25 && resultValue <=34.9){
                resultMessage = "اضافه وزن";
                resultSuggestion = "داری چاق میشی  ، یه کم مراعات کن";
                btnVisible = false;
              } else if(resultValue >35){
                resultMessage = "چاق";
                resultSuggestion = "اسید بخور تا لاغر شی";
                btnVisible = true;
              }
            });

            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
              ),
              context: context,
              builder: (context) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        width: 50,
                        height: 5,
                      ),
                    ),
                    bottomSheetLayout(),
                  ],
                );
              },
            );
          },
          child: const Text("مشاهده نتیجه",
              style: TextStyle(fontFamily: 'koodak')),
        ));
  }

//------------------------------------------------ Hint Text
  Widget generateHintText(String str) {
    return SizedBox(
        child: DecoratedBox(
            decoration:  BoxDecoration(
                color: const Color(0x20acacac),
                 border: Border.all(
                   color: const Color(0x05101010)
                 ),

                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                str,
                style: txtHintStyle,
                textAlign: TextAlign.end,
              ),
            )));
  }

//------------------------------------------------ Calculate BMI
  void calculateBMI() {
    double finalWeight = weight * 10000;
    double finalHeight = height * height;
    resultValue = finalWeight / finalHeight;
  }

//------------------------------------------------ BottomSheet
  Widget bottomSheetLayout() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(resultMessage,style: const TextStyle(fontSize: 20,fontFamily: 'titr'),),
        ),
        cardSpeedometer(),
        Text(resultSuggestion,style: const TextStyle(fontSize: 20,fontFamily: 'dalal')),
        Visibility(
          visible: btnVisible,
          child: OutlinedButton(onPressed: (){},child: SizedBox(
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text("راهکار پیشنهادی",style: TextStyle(fontFamily: 'dalal')),
                Icon(Icons.info_outline),

              ],
            ),
          ),),
        )

      ],
    );
  }
}
