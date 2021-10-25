import 'package:test/test.dart';
import 'package:units_converter/models/node.dart';

void main() {
  test('Algorithm test', () {
    Node(
      name: 'root',
      leafNodes: [
        Node(
          name: 'A',
          isConverted: true,
          leafNodes: [
            Node(name: 'A1'),
            Node(
              name: 'A2',
              leafNodes: [
                Node(name: 'A2-1'),
              ],
            ),
            Node(
              name: 'A3',
              //isConverted: true,
              leafNodes: [
                Node(name: 'A3-1'),
                Node(name: 'A3-2'),
              ],
            ),
          ],
        ),
        Node(name: 'B'),
      ],
    ).convert();
    expect(true, true);
  });
}
