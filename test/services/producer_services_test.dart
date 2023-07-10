import 'package:flutter_test/flutter_test.dart';
import 'package:organaki_app/models/producer.dart';
import 'package:organaki_app/services/producer_services.dart';
import 'package:result_dart/result_dart.dart';

void main() {
  group("Test Producer services", () {
    ProducerRepository producerRepo = ProducerRepository();
    test("Test get a producer function", () async {
      var response = await producerRepo.getAProducer("8dd0df98-78cb-4029-9303-9f2c33d8992c");
      expect(response, isA<Success>());
    });

     test("Test listProdcer function", () async {
      var response = await producerRepo.getListProducers();
      expect(response, isA<Success>());
    });

    test("Test tags list", () async {
      var response = await producerRepo.getTags();
      expect(response, isA<Success>());
    });

    test("Test tags list", () async {
      var producer = Producer(id: "8dd0df98-78cb-4029-9303-9f2c33d8992c", name: "Lucas Narciso", email: "lucasnar4@gmail.com", visible_producer: true, short_description: "Produtor local de software", address: "Lojinha de esquina verde", contact: "+55 99999-9999", opening_hours: "8h-17h", tags: ["sustentável"], lat: -20, lng: -20);
      var response = await producerRepo.editProducer(producer, "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJvcmdhbmFraV9hcGkiLCJleHAiOjE2OTEwNzYwMDQsImlhdCI6MTY4ODQ4NDAwNCwiaXNzIjoib3JnYW5ha2lfYXBpIiwianRpIjoiM2YzNzQ3MDEtY2EwOS00YTZiLWI4ZmQtZDhkOThjY2FmOWM2IiwibmJmIjoxNjg4NDg0MDAzLCJzdWIiOiI4ZGQwZGY5OC03OGNiLTQwMjktOTMwMy05ZjJjMzNkODk5MmMiLCJ0eXAiOiJhY2Nlc3MifQ.uv2snYu_uMP8Um8jVZzdpe9DMnp69Y4BtBCokXNk6o6IeY5xH2kFKDuFxNp1SmSyxV2cYM_2cmE20ZFJdd9gCA");
      expect(response, isA<Success>());
    });
  });
}
