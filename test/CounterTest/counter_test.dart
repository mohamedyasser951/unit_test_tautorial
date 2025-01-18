import 'package:flutter_test/flutter_test.dart';
import 'package:unit_test_tautorial/CounterExample/counter.dart';

void main() {
  group("Counter Test", () {
    late Counter counter;

    setUp(() {
      counter = Counter();
    });

    test("intial value should be Zero", () {
      expect(counter.count, 0);
    });

    test("Counter value should be increment", () {
      counter.increment();
      expect(counter.count, 1);
    });

    test("Counter value should be decrement", () {
      counter.increment();
      counter.decrement();

      expect(counter.count, 0);
    });

    test("Counter value should be below Zero", () {
      counter.decrement();

      expect(counter.count, -1);
    });
  });
}
