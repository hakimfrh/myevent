import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Controller class to manage the counter state
class CounterController extends GetxController {
  // Define a reactive variable to store the counter value
  var count = 0.obs;

  // Method to increment the counter
  void increment() {
    count.value++;
  }

  // Method to decrement the counter
  void decrement() {
    count.value--;
  }
}

class CounterScreen extends StatelessWidget {
  // Inject the CounterController using GetX
  final CounterController controller = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text('Count: ${controller.count}')),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Call the increment method of the controller
                controller.increment();
              },
              child: Text('Increment'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Call the decrement method of the controller
                controller.decrement();
              },
              child: Text('Decrement'),
            ),
          ],
        ),
      ),
    );
  }
}
