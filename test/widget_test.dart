import 'package:flutter/material.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meteo/presentation/ui/viewmodels/testscreen.dart';

void main() {
  group('TestScreen', () {
    testWidgets('should render the MapBoxAutoCompleteWidget', (tester) async {
      await tester.pumpWidget(TestScreen());
      expect(find.byType(MapBoxAutoCompleteWidget), findsOneWidget);
    });

    testWidgets('should render the DropdownButtonFormField', (tester) async {
      await tester.pumpWidget(TestScreen());
      expect(find.byType(DropdownButtonFormField), findsOneWidget);
    });

    testWidgets(
        'should show the weather data when the Get Weather button is pressed',
        (tester) async {
      await tester.pumpWidget(TestScreen());

      print("Tap on the MapBoxAutoCompleteWidget");
      await tester.tap(find.byType(MapBoxAutoCompleteWidget));
      await tester.pumpAndSettle();

      print("Enter a place name");
      await tester.enterText(
          find.byType(TextField), 'New York City, New York, United States');
      await tester.pumpAndSettle();

      print("Select a date");
      await tester.tap(find.text('Date'));
      await tester.pumpAndSettle();
      await tester.tap(find.text(
          DateTime.now().add(Duration(days: 1)).toString().substring(0, 10)));
      await tester.pumpAndSettle();

      print("Tap on the Get Weather button");
      await tester.tap(find.text('Get Weather'));
      await tester.pumpAndSettle();

      print("Verify that the weather data is displayed");
      expect(find.textContaining('Température max:'), findsOneWidget);
      expect(find.textContaining('Température min:'), findsOneWidget);
      expect(find.textContaining('Precipitation:'), findsOneWidget);
    });
  });
}
