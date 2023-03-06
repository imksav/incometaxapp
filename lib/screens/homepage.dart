import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _taxable = '0.00';
  double _exempt = 0.0;
  String _duesPayable = '0.00';
  String _takehome = '0.00';
  List<double> _dues = List.filled(5, 0);
//  double _dues[0];
  // for married
  var _cat1 = [600000, 800000, 1100000, 2000000];
  var _band1 = [600000, 200000, 300000, 900000];
  var _rate1 = [0.01, 0.1, 0.2, 0.3, 0.36];
  // for unmarried
  var _cat2 = [500000, 700000, 1000000, 2000000];
  var _band2 = [500000, 200000, 300000, 1000000];
  var _rate2 = [0.01, 0.1, 0.2, 0.3, 0.36];

  void _changeNumber(salary, marritalStatus) {
    salary = double.parse(salary);
    setState(() {
      if (_isTaxable(salary)) {
        double taxable = _getTaxableIncome(salary);
        _taxable = taxable.toStringAsFixed(2);
        if (marritalStatus == 'MARRIED') {
          double duesPayable = _calcTaxesMarried(taxable);
          _duesPayable = duesPayable.toStringAsFixed(2);
        } else {
          double duesPayable = _calcTaxesUnmarried(taxable);
          _duesPayable = duesPayable.toStringAsFixed(2);
          _takehome = (salary - (duesPayable)).toStringAsFixed(2);
          print(_takehome);
        }
      }
    });
  }

// tax calculation for married couple
  double _calcTaxesMarried(tsal) {
    if (tsal <= _cat1[0]) {
      _dues[0] = tsal * _rate1[0];
      return _dues[0];
    }
    if (tsal <= (_cat1[1])) {
      _dues[0] = _band1[0] * _rate1[0];
      _dues[1] = ((tsal - _cat1[0]) * _rate1[1]);
      return _dues[0] + _dues[1];
    }
    if (tsal <= _cat1[2]) {
      _dues[0] = _band1[0] * _rate1[0];
      _dues[1] = _band1[1] * _rate1[1];
      _dues[2] = ((tsal - _cat1[1]) * _rate1[2]);
      return _dues[0] + _dues[1] + _dues[2];
    }
    if (tsal <= _cat1[3]) {
      _dues[0] = _band1[0] * _rate1[0];
      _dues[1] = _band1[1] * _rate1[1];
      _dues[2] = _band1[2] * _rate1[2];
      _dues[3] = ((tsal - _cat1[2]) * _rate1[3]);
      return _dues[0] + _dues[1] + _dues[2] + _dues[3];
    }
    if (tsal > _cat1[4]) {
      _dues[0] = _band1[0] * _rate1[0];
      _dues[1] = _band1[1] * _rate1[1];
      _dues[2] = _band1[2] * _rate1[2];
      _dues[3] = _band1[3] * _rate1[3];
      _dues[4] = ((tsal - _cat1[4]) * _rate1[4]);
    }
    return _dues[0] + _dues[1] + _dues[2] + _dues[3] + _dues[4];
  }

  // tax calculation for unmarried single
  double _calcTaxesUnmarried(tsal) {
    if (tsal <= _cat2[0]) {
      _dues[0] = tsal * _rate2[0];
      return _dues[0];
    }
    if (tsal <= (_cat2[1])) {
      _dues[0] = _band2[0] * _rate2[0];
      _dues[1] = ((tsal - _cat2[0]) * _rate2[1]);
      return _dues[0] + _dues[1];
    }
    if (tsal <= _cat2[2]) {
      _dues[0] = _band2[0] * _rate2[0];
      _dues[1] = _band2[1] * _rate2[1];
      _dues[2] = ((tsal - _cat2[1]) * _rate2[2]);
      return _dues[0] + _dues[1] + _dues[2];
    }
    if (tsal <= _cat2[3]) {
      _dues[0] = _band2[0] * _rate2[0];
      _dues[1] = _band2[1] * _rate2[1];
      _dues[2] = _band2[2] * _rate2[2];
      _dues[3] = ((tsal - _cat2[2]) * _rate2[3]);
      return _dues[0] + _dues[1] + _dues[2] + _dues[3];
    }
    if (tsal > _cat2[4]) {
      _dues[0] = _band2[0] * _rate2[0];
      _dues[1] = _band2[1] * _rate2[1];
      _dues[2] = _band2[2] * _rate2[2];
      _dues[3] = _band2[3] * _rate2[3];
      _dues[4] = ((tsal - _cat2[4]) * _rate2[4]);
    }
    return _dues[0] + _dues[1] + _dues[2] + _dues[3] + _dues[4];
  }

  bool _isTaxable(amount) {
    return (amount > 0) ? true : false;
  }

  double _getTaxableIncome(amount) {
    return amount - _exempt;
  }

  String _maritalStatusValue = 'Married';

  var _maritalstatus = ['Married', 'UnMarried'];

  List<double> data = [];

  double income = 0;
  double tax = 0;
  final TextEditingController _monthlyIncome = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Income Tax Calculator Nepal 2079/80"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                // print("Pressed");
              },
              icon: const Icon(Icons.tips_and_updates_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.0),
                    color: Colors.amberAccent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      value: _maritalStatusValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: _maritalstatus.map((String maritalstatus) {
                        return DropdownMenuItem(
                          value: maritalstatus,
                          child: Text(maritalstatus),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _maritalStatusValue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _monthlyIncome,
                        onChanged: (text) {
                          _changeNumber(
                              text, _maritalStatusValue.toUpperCase());
                        },
                        decoration: const InputDecoration(
                          labelText: 'Salary',
                          prefixText: 'NPR ',
                          helperText: 'Enter your monthly salary',
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                          signed: false,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        onPressed: () {
                          income = double.parse(_monthlyIncome.text);

                          _changeNumber(
                              _monthlyIncome.text, _maritalStatusValue);
                        },
                        child: Text(
                          "Calculate Tax",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        color: Colors.red,
                        elevation: 5.0,
                        textColor: Colors.white,
                        splashColor: Colors.green,
                      ),
                    ),
                    Center(
                      child: Card(
                        elevation: 3.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Your Taxable Amount is ${_takehome}")
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // List taxForMarried(double yearlyIncome) {
  //   double taxAmount = 0;
  //   double slab1 = 0;
  //   double slab2 = 0;
  //   double slab3 = 0;
  //   double slab4 = 0;
  //   double slab5 = 0;
  //   if (yearlyIncome <= 600000) {
  //     // SLAB
  //     slab1 += (1 / 100) * 600000;
  //     //
  //     taxAmount += (1 / 100) * yearlyIncome;
  //   } else if (yearlyIncome <= 800000) {
  //     // SLAB
  //     slab1 += (1 / 100) * 600000;
  //     slab2 += (10 / 100) * (200000);
  //     //
  //     taxAmount += ((1 / 100) * 600000) + (10 / 100) * (yearlyIncome - 600000);
  //   } else if (yearlyIncome <= 1100000) {
  //     // SLAB
  //     slab1 += (1 / 100) * 600000;
  //     slab2 += (10 / 100) * (200000);
  //     slab3 += (20 / 100) * (300000);
  //     //
  //     taxAmount += ((1 / 100) * 600000) +
  //         ((10 / 100) * 200000) +
  //         (20 / 100) * (yearlyIncome - 800000);
  //   } else if (yearlyIncome <= 1800000) {
  //     // SLAB
  //     slab1 += (1 / 100) * 600000;
  //     slab2 += (10 / 100) * (200000);
  //     slab3 += (20 / 100) * (300000);
  //     slab4 += (30 / 100) * (700000);
  //     //
  //     taxAmount += ((1 / 100) * 600000) +
  //         ((10 / 100) * 200000) +
  //         (20 / 100) * (300000) +
  //         (30 / 100) * (yearlyIncome - 1100000);
  //   } else {
  //     // SLAB
  //     slab1 += (1 / 100) * 600000;
  //     slab2 += (10 / 100) * (200000);
  //     slab3 += (20 / 100) * (300000);
  //     slab4 += (30 / 100) * (900000);
  //     slab5 += (36 / 100) * (yearlyIncome - 2000000);
  //     //
  //     taxAmount += ((1 / 100) * 600000) +
  //         ((10 / 100) * 200000) +
  //         (20 / 100) * (300000) +
  //         (30 / 100) * (900000) +
  //         (36 / 100) * (yearlyIncome - 2000000);
  //   }
  //   data = [slab1, slab2, slab3, slab4, slab5, taxAmount];
  //   List<Widget> widgets = data.map((item) {
  //     return Text(item.toString());
  //   }).toList();
  //   return widgets;
  //   // print(
  //   //     "Slab1: $slab1\nSlab2: $slab2\nSlab3: $slab3\nSlab4: $slab4\nSlab5: $slab5");
  //   // print("Your Total Taxable Amount is $taxAmount");
  //   // Yearly = 2268000
  //   // Taxable = 525980.0
  //   // Net = 1742020.0
  // }

  // //
  // void taxForUnMarried(double yearlyIncome) {
  //   double taxAmount = 0;
  //   double slab1 = 0;
  //   double slab2 = 0;
  //   double slab3 = 0;
  //   double slab4 = 0;
  //   double slab5 = 0;
  //   if (yearlyIncome <= 500000) {
  //     // SLAB
  //     slab1 += (1 / 100) * 500000;
  //     //
  //     taxAmount += (1 / 100) * yearlyIncome;
  //   } else if (yearlyIncome <= 700000) {
  //     // SLAB
  //     slab1 += (1 / 100) * 500000;
  //     slab2 += (10 / 100) * (200000);
  //     //
  //     taxAmount += ((1 / 100) * 500000) + (10 / 100) * (yearlyIncome - 500000);
  //   } else if (yearlyIncome <= 1000000) {
  //     // SLAB
  //     slab1 += (1 / 100) * 500000;
  //     slab2 += (10 / 100) * (200000);
  //     slab3 += (20 / 100) * (300000);
  //     //
  //     taxAmount += ((1 / 100) * 500000) +
  //         ((10 / 100) * 200000) +
  //         (20 / 100) * (yearlyIncome - 700000);
  //   } else if (yearlyIncome <= 1000000) {
  //     // SLAB
  //     slab1 += (1 / 100) * 500000;
  //     slab2 += (10 / 100) * (200000);
  //     slab3 += (20 / 100) * (300000);
  //     slab4 += (30 / 100) * (1000000);
  //     //
  //     taxAmount += ((1 / 100) * 500000) +
  //         ((10 / 100) * 200000) +
  //         (20 / 100) * (300000) +
  //         (30 / 100) * (yearlyIncome - 2000000);
  //   } else {
  //     // SLAB
  //     slab1 += (1 / 100) * 500000;
  //     slab2 += (10 / 100) * (200000);
  //     slab3 += (20 / 100) * (300000);
  //     slab4 += (30 / 100) * (1000000);
  //     slab5 += (36 / 100) * (yearlyIncome - 2000000);
  //     //
  //     taxAmount += ((1 / 100) * 500000) +
  //         ((10 / 100) * 200000) +
  //         (20 / 100) * (300000) +
  //         (30 / 100) * (1000000) +
  //         (36 / 100) * (yearlyIncome - 2000000);
  //   }

  //   print(
  //       "Slab1: $slab1\nSlab2: $slab2\nSlab3: $slab3\nSlab4: $slab4\nSlab5: $slab5");
  //   print("Your Total Taxable Amount is $taxAmount");
  // Yearly = 5424
  // Taxable = 54.24
  // Net = 5369.76
}
// }
