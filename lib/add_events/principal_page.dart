import 'package:chronomap_in_maritime/add_events/phone_body.dart';
import 'package:flutter/material.dart';
import 'tablet_body.dart';

class PrincipalPage extends StatelessWidget {
  const PrincipalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return const TabletBody();  // Load tablet layout
        } else {
          return const PhoneBody();  // Load phone layout
        }
      },
    );
  }
}
