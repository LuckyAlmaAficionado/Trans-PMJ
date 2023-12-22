import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/empty_trip_controller.dart';

class EmptyTripView extends GetView<EmptyTripController> {
  const EmptyTripView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EmptyTripView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EmptyTripView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
