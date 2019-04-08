import 'package:scrape/scrape.dart' as scrape;
import 'dart:convert';

import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  MockClient client = null;

  test('calling initiate(client) returns a list of storylinks', () async {
    // Arrange
    client = MockClient((req) => Future(() => Response('''
      <body>
        <table><tbody><tr>
        <td class="title">
          <a class="storylink" href="https://dartlang.org">Get started with Dart</a>
        </td>
        </tr></tbody></table>
      </body>
    ''', 200)));

    // Act
    var response = await scrape.initiate(client);

    // Assert
    expect(
        response,
        equals(json.encode([
          {
            'title': 'Get started with Dart',
            'href': 'https://dartlang.org',
          }
        ])));
  });
}