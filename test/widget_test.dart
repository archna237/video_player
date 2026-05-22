import 'package:flutter_test/flutter_test.dart';
import 'package:video_player/app.dart';
import 'package:video_player/main.dart';

void main() {
  testWidgets('Splash screen loads in English', (WidgetTester tester) async {
    await tester.pumpWidget(VideoPlayerApp(localeController: localeController));
    expect(find.text('Video Player'), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
  });
}
