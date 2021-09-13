import 'package:flutter_cars_app/core/core.dart';
import 'package:flutter_cars_app/data/datasource/car_remote_data_source.dart';
import 'package:flutter_cars_app/data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../data/json_reader.dart';
import 'car_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late CarRemoteDataSourceImpl dataSource;
  final mockClient = MockClient();

  setUp(() {
    dataSource = CarRemoteDataSourceImpl(client: mockClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(readJsonAsString('car_list.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getCarList', () {
    final List<CarModel> mockCarModelList =
          getCarModelListFromJson(readJsonAsString('car_list.json'));

    test(
      'should return CarList when the response code is 200 (success)',
          () async {

        setUpMockHttpClientSuccess200();

        final result = await dataSource.getCarList();

        expect(result, equals(mockCarModelList));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
          () async {
        setUpMockHttpClientFailure404();

        final call = dataSource.getCarList;

        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}