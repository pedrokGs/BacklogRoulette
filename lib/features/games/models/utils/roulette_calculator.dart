import 'dart:math';

class RouletteCalculator<T> {
  final Map<T, double> weightedItems;
  final Random _random = Random();

  RouletteCalculator(this.weightedItems);

  T pickWinner() {
    if (weightedItems.isEmpty) throw Exception("Nenhum item para sortear!");

    double totalWeight = weightedItems.values.fold(0, (sum, weight) => sum + weight);

    double randomPoint = _random.nextDouble() * totalWeight;

    double currentSum = 0;
    for (var entry in weightedItems.entries) {
      currentSum += entry.value;
      if (randomPoint <= currentSum) {
        return entry.key;
      }
    }

    return weightedItems.keys.first; // Fallback
  }
}