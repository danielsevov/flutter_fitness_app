import 'package:flutter_test/flutter_test.dart';
import 'package:lift_to_live_flutter/domain/entities/image.dart';

import '../test_data.dart';

void main() {
  test('Image constructor test', () {
    final image = TestData.test_image_1;

    expect(image.date, 'A');
    expect(image.id, 1);
    expect(image.userId, 'A');
    expect(image.type, 'A');
    expect(image.data, 'A');
  });

  group('Image toJson tests', (){
    test('Image toJson compared to self', () {
      final image = TestData.test_image_1;

      expect(image.toJson().toString() == image.toJson().toString(), true);
    });

    test('Image toJson compared to self 2', () {
      final image = TestData.test_image_1;

      expect(image.toJson().toString(), '{user_id: A, type: A, id: 1, date: A, data: A}');
    });

    test('Image toJson compared to other', () {
      final image = TestData.test_image_1;
      final image2 = TestData.test_image_2;

      expect(image.toJson().toString() == image2.toJson().toString(), false);
    });
  });

  group('Image fromJson tests', (){
    test('Image fromJson compared to self', () {
      final image = TestData.test_image_1;
      final imageJson = image.toJson();

      expect(image == MyImage.fromJson(imageJson), true);
    });

    test('Image fromJson compared to other Image', () {
      final image = TestData.test_image_1;
      final image2 = TestData.test_image_2;
      final imageJson = image2.toJson();

      expect(image == MyImage.fromJson(imageJson), false);
    });
  });

  group('Image equals tests', (){
    test('Image equals compared to self', () {
      final image = TestData.test_image_1;

      expect(image == image, true);
    });

    test('Image equals compared to self 2', () {
      final MyImage image = TestData.test_image_1;
      final image2 = MyImage('A', 'A', 1, 'A', 'A');

      expect(image == image2, true);
    });

    test('Image equals compared to other Image', () {
      final image = TestData.test_image_1;
      final image2 = TestData.test_image_2;

      expect(image == image2, false);
    });
  });

  group('Image hashCode tests', (){
    test('Image hashCode compared to self', () {
      final image = TestData.test_image_1;

      expect(image.hashCode == image.hashCode, true);
    });

    test('Image hashCode compared to self 2', () {
      final image = TestData.test_image_1;
      final image2 = MyImage('A', 'A', 1, 'A', 'A');

      expect(image.hashCode == image2.hashCode, true);
    });

    test('Image hashCode compared to other Image', () {
      final image = TestData.test_image_1;
      final image2 = TestData.test_user_1;

      expect(image.hashCode == image2.hashCode, false);
    });
  });

  group('Image toString tests', (){
    test('Image toString test', () {
      final image = TestData.test_image_1;
      final imageToString = image.toString();

      expect(imageToString == 'MyImage{userId: A, type: A, data: A, date: A, id: 1}', true);
    });

    test('Image toString test', () {
      final image = TestData.test_image_1;
      final image2 = TestData.test_image_2;

      expect(image.toString() == image2.toString(), false);
    });
  });
}
