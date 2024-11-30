import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Currency { Euro, Riel, Dong }

extension CurrencyExtension on Currency {
  String get name {
    switch (this) {
      case Currency.Euro:
        return 'Euro';
      case Currency.Riel:
        return 'Riel';
      case Currency.Dong:
        return 'Dong';
    }
  }

  double get rate {
    switch (this) {
      case Currency.Euro:
        return 0.91; // 1 USD = 0.91 Euro
      case Currency.Riel:
        return 4100.0; // 1 USD = 4100 Riel
      case Currency.Dong:
        return 24000.0; // 1 USD = 24000 Dong
    }
  }
}

class DeviceConverter extends StatefulWidget {
  const DeviceConverter({super.key});

  @override
  State<DeviceConverter> createState() => _DeviceConverterState();
}

class _DeviceConverterState extends State<DeviceConverter> {
  final TextEditingController _controller = TextEditingController();
  Currency selectedCurrency = Currency.Euro;
  double convertedAmount = 0.0;

  void _convertCurrency() {
    final String input = _controller.text;

    if (input.isNotEmpty) {
      final double amountInDollars = double.tryParse(input) ?? 0.0;
      setState(() {
        convertedAmount = amountInDollars * selectedCurrency.rate;
      });
    }
  }

  final BoxDecoration textDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.money,
            size: 60,
            color: Colors.white,
          ),
          const Center(
            child: Text(
              "Converter",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          const SizedBox(height: 50),
          const Text("Amount in dollars:"),
          const SizedBox(height: 10),

          TextField(
              onChanged: (value) => _convertCurrency(),
              controller: _controller,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                  prefix: const Text('\$ '),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Enter an amount in dollar',
                  hintStyle: const TextStyle(color: Colors.white)),
              style: const TextStyle(color: Colors.white)),

          const SizedBox(height: 30),
          // const Text("Device: (TODO !)"),

          // const SizedBox(height: 30),
          // const Text("Amount in selected device:"),
          Row(
            children: [
              const Text('Device:'),
              const SizedBox(width: 16),
              DropdownButton<Currency>(
                value: selectedCurrency,
                onChanged: (Currency? newCurrency) {
                  setState(() {
                    selectedCurrency = newCurrency!;
                    _convertCurrency();
                  });
                },
                items: Currency.values.map((Currency currency) {
                  return DropdownMenuItem<Currency>(
                    value: currency,
                    child: Text(currency.name),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: textDecoration,
            child: Text(
              'Converted Amount: ${convertedAmount.toStringAsFixed(2)} ${selectedCurrency.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
        ],
      )),
    );
  }
}
