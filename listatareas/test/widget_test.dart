// Esta es una prueba básica del widget de Flutter.
//
// Para realizar una interacción con un widget en su prueba, usamos WidgetTester
// que es una utilidad que proporciona Flutter. Por ejemplo, puede enviar tocar y desplazar
// gestos. También puede usar WidgetTester para encontrar widgets secundarios en el widget
// árbol, lea el texto y verifique que los valores de las propiedades del widget sean correctos.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:listatareas/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Crea nuestra aplicación y active un marco.
    await tester.pumpWidget(MyApp());

    // Verifica que nuestro contador comience en 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Toque el ícono '+' y active un cuadro..
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verifica que nuestro contador haya incrementado
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
