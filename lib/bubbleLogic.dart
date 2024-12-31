import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BubbleLogic with ChangeNotifier {
  List<int> numbers = [];
  int? comparingIndex;
  int? swappingIndex;
  TextEditingController inputController = TextEditingController();

  BubbleLogic() {
    generateRandomList();
  }

  void generateRandomList() {
    numbers = [];
    inputController.clear();
    notifyListeners();
  }

  void generateListFromInput(String input) {
    final parsedNumbers = input
        .split(',')
        .map((e) => int.tryParse(e.trim()))
        .where((e) => e != null)
        .toList();
    if (parsedNumbers.isNotEmpty) {
      numbers = parsedNumbers.cast<int>();

      comparingIndex = null;
      swappingIndex = null;
      notifyListeners();
    }
  }

  Future<void> bubbleSort() async {
    for (int i = 0; i < numbers.length - 1; i++) {
      for (int j = 0; j < numbers.length - 1 - i; j++) {
        comparingIndex = j;
        swappingIndex = j + 1;
        notifyListeners();

        await Future.delayed(const Duration(milliseconds: 300));

        if (numbers[j] > numbers[j + 1]) {
          final temp = numbers[j];
          numbers[j] = numbers[j + 1];
          numbers[j + 1] = temp;
          notifyListeners();

          await Future.delayed(const Duration(milliseconds: 300));
        }
      }
    }

    comparingIndex = null;
    swappingIndex = null;
    notifyListeners();
  }
}
