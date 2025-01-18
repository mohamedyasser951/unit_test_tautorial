import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unit_test_tautorial/CounterCubit/counter_cubit.dart';

void main() {
  late CounterCubit counterCubit;

  setUp(() {
    counterCubit = CounterCubit();
  });

  tearDown(() {
    counterCubit.close();
  });

  group("Counter Cubit", () {
    test("intial state equal be zero", () {
      expect(counterCubit.state, 0);
    });

    blocTest<CounterCubit, int>(
      "emit state when increment",
      build: () => counterCubit,
      act: (bloc) => counterCubit.increment(),
      expect: () => [1],
    );

    blocTest<CounterCubit, int>(
      "emit state when decrement",
      build: () => counterCubit,
      act: (bloc) => counterCubit.decrement(),
      expect: () => [-1],
    );
  });
}
