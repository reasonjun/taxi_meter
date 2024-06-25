import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/drive_button_view_model.dart';

class MeterPage extends StatelessWidget {
  const MeterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('택시 미터기')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DriveButton(),
          ],
        ),
      ),
    );
  }
}

class DriveButton extends StatelessWidget {
  const DriveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DriveButtonViewModel>(
      builder: (context, viewModel, child) {
        // Define the text based on the driving state
        final buttonText = viewModel.isDriving ? "주행종료" : "주행시작";

        return TextButton(
          onPressed: viewModel.toggleDriving,
          child: Text(buttonText),
        );
      },
    );
  }
}
