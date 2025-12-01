import 'package:flutter/material.dart';
import 'package:organizer/presentation/widgets/elements/synchronize/synchronize_connect_mobile.dart';

class SetupScreenMobile extends StatelessWidget {
  const SetupScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Setup'),
          automaticallyImplyLeading: false,
        ),
        body: const SynchronizeConnectMobile(),
      ),
    );
  }
}
