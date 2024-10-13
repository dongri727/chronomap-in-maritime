import 'package:flutter/material.dart';
import 'shadowed_container.dart';

class NavigationButton extends StatelessWidget {
  final Widget destinationPage;
  final String buttonText;

  const NavigationButton({
    super.key,
    required this.destinationPage,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ShadowedContainer(
        child: TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.blueGrey),
          child: Text(buttonText, style: const TextStyle(color: Colors.white)),
          onPressed: () => Navigator.push<String>(
            context,
            MaterialPageRoute(builder: (context) => destinationPage),
          ),
        ),
      ),
    );
  }
}