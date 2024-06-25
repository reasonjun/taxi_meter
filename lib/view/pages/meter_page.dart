import 'package:flutter/material.dart';
import 'package:location/location.dart';
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SpeedWidget(),
                DistanceWidget(),
              ],
            ),
            SizedBox(height: 20), // Add some spacing between the rows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                DriveButton(),
                SurchargeButton(),
              ],
            ),
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

        return ElevatedButton(
          onPressed: viewModel.toggleDriving,
          child: Text(buttonText),
        );
      },
    );
  }
}

class SurchargeButton extends StatelessWidget {
  const SurchargeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {},
      child: const Text("할증"),
    );
  }
}

class SpeedWidget extends StatelessWidget {
  const SpeedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DriveButtonViewModel>(
      builder: (context, viewModel, child) {
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PermissionStatusWidget(),
            Text(
              '현재 속도',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'km/h',
              // '${viewModel.currentSpeed.toStringAsFixed(1)} km/h',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}

class DistanceWidget extends StatelessWidget {
  const DistanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DriveButtonViewModel>(
      builder: (context, viewModel, child) {
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '이동 거리',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'km',
              // '${viewModel.distanceTravelled.toStringAsFixed(1)} km',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}

class PermissionStatusWidget extends StatefulWidget {
  const PermissionStatusWidget({super.key});

  @override
  _PermissionStatusState createState() => _PermissionStatusState();
}

class _PermissionStatusState extends State<PermissionStatusWidget> {
  final Location location = Location();

  PermissionStatus? _permissionGranted;

  Future<void> _checkPermissions() async {
    final permissionGrantedResult = await location.hasPermission();
    setState(() {
      _permissionGranted = permissionGrantedResult;
    });
  }

  Future<void> _requestPermission() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final permissionRequestedResult = await location.requestPermission();
      setState(() {
        _permissionGranted = permissionRequestedResult;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Permission status: ${_permissionGranted ?? "unknown"}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 42),
              child: ElevatedButton(
                onPressed: _checkPermissions,
                child: const Text('Check'),
              ),
            ),
            ElevatedButton(
              onPressed: _permissionGranted == PermissionStatus.granted
                  ? null
                  : _requestPermission,
              child: const Text('Request'),
            ),
          ],
        ),
      ],
    );
  }
}
