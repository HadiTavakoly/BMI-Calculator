import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  double aaa = 0;

  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();

  final Color _color = const Color(0xfffeec3a);

  String result = '0.0';
  double numResult = 0.00;
  Widget text = const Text('');

  int radioValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'BMI Calculator',
          style: TextStyle(color: _color, fontSize: 20),
        ),
      ),
      backgroundColor: Colors.grey[800],
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          maxLength: 3,
                          validator: (String? value) {
                            if (value!.isNotEmpty) {
                              aaa = double.parse(value);
                              if (radioValue == 1) {
                                if (aaa < 0.6) {
                                  return 'قد باید بیشتر از 0.6 متر باشد';
                                }
                              }
                              if (radioValue == 2) {
                                if (aaa < 60) {
                                  return 'قد باید بیشتر از 60 سانتی متر باشد';
                                }
                              }
                            } else {
                              return 'لطفا قد را وارد کنید';
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'(^[|\+|0-9][0-9]*)(\.*)[0-9]*$'))
                          ],
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: 35,
                            color: _color,
                          ),
                          controller: height,
                          decoration: InputDecoration(
                            helperStyle: const TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                            errorStyle: const TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                            errorMaxLines: 3,
                            hintText: 'قد',
                            hintStyle: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w300,
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: TextFormField(
                          maxLength: 3,
                          validator: (String? value) {
                            if (value!.isNotEmpty) {
                              aaa = double.parse(value);
                              if (aaa < 30) {
                                return 'وزن باید بیشتر از 30  کیلوگرم باشد';
                              }
                              if (aaa > 500) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      textDirection: TextDirection.rtl,
                                      'وزن نمی تواند بیشتر از 500 کیلو گرم باشد(لطفا آن را تغییر دهید)',
                                    ),
                                  ),
                                );
                              }
                            } else {
                              return 'لطفا وزن را وارد کنید';
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'(^[|\+|0-9][0-9]*)(\.*)[0-9]*$'),
                            ),
                          ],
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: 35,
                            color: _color,
                          ),
                          controller: weight,
                          decoration: InputDecoration(
                            helperStyle: const TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                            errorStyle: const TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                            errorMaxLines: 3,
                            hintText: 'وزن',
                            hintStyle: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w300,
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: RadioListTile(
                        title: const Text(
                          'متر',
                          style: TextStyle(color: Colors.white),
                        ),
                        value: 1,
                        groupValue: radioValue,
                        onChanged: (int? groupValue) {
                          setState(() {
                            radioValue = groupValue!;
                          });
                        }),
                  ),
                  Expanded(
                    child: RadioListTile(
                        title: const Text(
                          'سانتی متر',
                          style: TextStyle(color: Colors.white),
                        ),
                        value: 2,
                        groupValue: radioValue,
                        onChanged: (int? groupValue) {
                          setState(() {
                            radioValue = groupValue!;
                          });
                        }),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (radioValue == 1) {
                      return metricBmi();
                    }
                    if (radioValue == 2) {
                      return cMetricBmi();
                    }
                  }
                },
                child: Text(
                  'محاسبه',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: _color,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: text,
              ),
              radialGauge(),
            ],
          ),
        ),
      ),
    );
  }

  SfRadialGauge radialGauge() {
    return SfRadialGauge(
      enableLoadingAnimation: true,
      axes: <RadialAxis>[
        RadialAxis(
          startAngle: 180,
          endAngle: 0,
          minimum: 0,
          maximum: 50,
          interval: 5,
          minorTicksPerInterval: 10,
          useRangeColorForAxis: true,
          ranges: <GaugeRange>[
            GaugeRange(
                label: ' کاهش وزن ',
                labelStyle: const GaugeTextStyle(
                    fontWeight: FontWeight.bold, fontSize: 13),
                rangeOffset: -10,
                startValue: 0,
                endValue: 18.5,
                color: Colors.red),
            GaugeRange(
                label: 'سالم',
                labelStyle: const GaugeTextStyle(
                    fontWeight: FontWeight.bold, fontSize: 13),
                rangeOffset: -10,
                startValue: 18.5,
                endValue: 24.9,
                color: Colors.green),
            GaugeRange(
                label: 'اضافه وزن',
                labelStyle: const GaugeTextStyle(
                    fontWeight: FontWeight.bold, fontSize: 13),
                rangeOffset: -10,
                startValue: 24.9,
                endValue: 29.9,
                color: Colors.orange),
            GaugeRange(
                label: 'چاقی',
                labelStyle: const GaugeTextStyle(
                    fontWeight: FontWeight.bold, fontSize: 13),
                rangeOffset: -10,
                startValue: 29.9,
                endValue: 50,
                color: const Color.fromARGB(255, 236, 23, 7))
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: numResult,
              needleLength: 0.7,
              needleColor: Colors.orangeAccent,
              enableAnimation: true,
              animationType: AnimationType.bounceOut,
            )
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
                widget: Text(
                  'BMI = ${result.toString()}',
                  style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
                angle: 90,
                positionFactor: 0.5)
          ],
        )
      ],
    );
  }

  Widget matn(numResult) {
    if (numResult < 18.50) {
      return const Text(
        'وزنت کمه 🤔',
        style: TextStyle(
          fontSize: 35,
          color: Colors.white,
        ),
      );
    } else if (numResult >= 18.50 && numResult < 24.9) {
      return const Text(
        'سالمی 🥳',
        style: TextStyle(
          fontSize: 35,
          color: Colors.white,
        ),
      );
    } else if (numResult >= 24.9 && numResult < 29.9) {
      return Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'وزنت زیاده 😢',
            style: TextStyle(
              fontSize: 35,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          IconButton(
            onPressed: () {
              setState(
                () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        title: Text('توصیه مهم',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 40,
                                color: Colors.blue),
                            textDirection: TextDirection.rtl),
                        content: Text('* ورزش کن \n * رژیم غذاییت رو کنترل کن',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                            textDirection: TextDirection.rtl),
                      );
                    },
                  );
                },
              );
            },
            icon: Icon(
              Icons.help_outline,
              color: Colors.blue.withOpacity(0.8),
              size: 40,
            ),
          ),
        ],
      );
    } else {
      return const Text(
        'چاقی 😬',
        style: TextStyle(
          fontSize: 35,
          color: Colors.white,
        ),
      );
    }
  }

  void metricBmi() {
    return setState(
      () {
        result = (num.parse(weight.text) /
                (num.parse(height.text) * num.parse(height.text)))
            .toStringAsFixed(2);
        numResult = double.parse(result);
        text = matn(numResult);
      },
    );
  }

  void cMetricBmi() {
    return setState(
      () {
        result = (num.parse(weight.text) /
                (num.parse(height.text) / 100 * num.parse(height.text) / 100))
            .toStringAsFixed(2);
        numResult = double.parse(result);
        text = matn(numResult);
      },
    );
  }
}
