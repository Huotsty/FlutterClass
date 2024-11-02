import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

enum IconPosition { before, after, defaultPosition }
enum ButtonType { primary, secondary, disabled }

class Button {
  final ButtonType type;
  final IconData icon;
  final String label;
  final IconPosition iconPosition;

  const Button({
    required this.type,
    required this.icon,
    required this.label,
    this.iconPosition = IconPosition.defaultPosition,
  });
}

const Color primaryColor = Colors.blue;
const Color secondaryColor = Colors.green;
const Color disabledColor = Colors.grey;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const buttons = [
      Button(
        type: ButtonType.primary,
        icon: Icons.check,
        label: 'Submit',
        iconPosition: IconPosition.before,
      ),
      Button(
        type: ButtonType.secondary,
        icon: Icons.access_time,
        label: 'Time',
        iconPosition: IconPosition.after,
      ),
      Button(
        icon: Icons.account_tree,
        type: ButtonType.disabled,
        label: 'Account',
      )
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Custom Buttons'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buttons.map((button) => CustomButton(button: button)).toList(),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.button,
  });

  final Button button;

  Color getButtonColor() {
    switch (button.type) {
      case ButtonType.primary:
        return primaryColor;
      case ButtonType.secondary:
        return secondaryColor;
      case ButtonType.disabled:
        return disabledColor;
      default:
        return Colors.amber;
    }
  }

  // Build the button with the icon positioned according to iconPosition
  List<Widget> buildButtonContent() {
    if (button.iconPosition == IconPosition.before) {
      return [
        Icon(button.icon, color: Colors.white, size: 20.0),
        const SizedBox(width: 20.0),
        Text(button.label, style: const TextStyle(fontSize: 30, color: Colors.white)),
      ];
    } else if (button.iconPosition == IconPosition.after) {
      return [
        Text(button.label, style: const TextStyle(fontSize: 30, color: Colors.white)),
        const SizedBox(width: 20.0),
        Icon(button.icon, color: Colors.white, size: 20.0),
      ];
    } else {
      // Default: icon before text
      return [
        Icon(button.icon, color: Colors.white, size: 20.0),
        const SizedBox(width: 20.0),
        Text(button.label, style: const TextStyle(fontSize: 30, color: Colors.white)),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: getButtonColor(),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: buildButtonContent(),
        ),
      ),
    );
  }
}
