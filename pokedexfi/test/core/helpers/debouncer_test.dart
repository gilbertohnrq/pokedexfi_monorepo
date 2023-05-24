import 'package:flutter_test/flutter_test.dart';
import 'package:pokedexfi/core/helpers/debouncer.dart';

void main() {
  group('Debounce', () {
    testWidgets('should run the action after the specified duration',
        (tester) async {
      int counter = 0;
      final debounce = Debounce(milliseconds: 500);

      debounce.run(() {
        counter++;
      });

      expect(counter, 0);

      await tester.pump(const Duration(milliseconds: 400));
      expect(counter, 0);

      await tester.pump(const Duration(milliseconds: 100));
      expect(counter, 1);
    });

    testWidgets('should cancel the action when dispose is called',
        (tester) async {
      int counter = 0;
      final debounce = Debounce(milliseconds: 500);

      debounce.run(() {
        counter++;
      });

      expect(counter, 0);

      await tester.pump(const Duration(milliseconds: 400));
      expect(counter, 0);

      debounce.dispose();

      await tester.pump(const Duration(milliseconds: 100));
      expect(counter, 0);
    });
  });
}
