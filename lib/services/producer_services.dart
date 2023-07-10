import 'package:dio/dio.dart';
import 'package:organaki_app/core/endpoints.dart';
import 'package:organaki_app/models/producer.dart';
import 'package:result_dart/result_dart.dart';

abstract class ProducerService {
  Future<Result<List<Producer>, String>> getListProducers();
  getAProducer(String id);
  editProducer(Producer producer, String token);
}

class ProducerRepository implements ProducerService {
  final dio = Dio();
  String? errorMessage;

  @override
  Future<Result<List<Producer>, String>> getListProducers() async {
    //Map<String, dynamic>? params = {"username":username, "password": password};
    // Map<String, dynamic>? header = {};
    // Map body = {};
    var response = await dio.get(
      Endpoints.baseUrl + Endpoints.producers,
      // queryParameters: params, data: body, options: Options(headers: header)
    );
    try {
      if (response.statusCode == 200) {
        List<Producer> listProducer = [];
        var listProducerMap = response.data["producers"];

        for (int i = 0; i < listProducerMap.length; i++) {
          listProducer.add(Producer.fromMap(listProducerMap[i]));
        }

        return Success(listProducer);
      } else if (response.statusCode == 400) {
        errorMessage = "Chamada feita de maneira errada";
      } else if (response.statusCode == 500) {
        errorMessage = "Sistema fora do ar, contate o adiminstrador";
      }
    } catch (e) {
      print(
          "${response.statusCode} Error ProducerRepository ::  getListProducers :: $e ");
      errorMessage = "Erro do sistema";
    }
    return Failure(errorMessage ?? "Erro não esperado");
  }

  //  String id;
  @override
  Future<Result<String, String>> editProducer(
      Producer producer, String token) async {
    Map body = {"producer": {}};
    var producerMap = producer.toMap();
    Map newProducerMap = {};
    producerMap.forEach((key, value) {
      if (value != "" && value != null) {
        newProducerMap.addAll({key: value});
      }
    });

    body["producer"].addAll(newProducerMap);
    body["producer"]["visible_producer"] = checkAllFieldsProducer(producer);
    Map<String, dynamic> header = {"Authorization": "Bearer $token"};

    try {
      var response = await dio.put(
          "${Endpoints.baseUrl}${Endpoints.producers}/${producer.id}",
          data: body,
          options: Options(headers: header));
      if (response.statusCode == 200) {
        return const Success("Atualizado com sucesso");
      }
    } catch (e) {
      print("Error AuthenticationRepository :: updateUser :: $e");
      errorMessage = "Erro do sistema";
    }
    return Failure(errorMessage ?? "Erro não esperado");
  }

  @override
  Future<Result<Producer, String>> getAProducer(String id) async {
    var response = await dio.get(
      "${Endpoints.baseUrl}${Endpoints.producers}/$id",
    );
    try {
      if (response.statusCode == 200) {
        Producer prod = Producer.fromMap(response.data["producer"]);
        print(prod);
        return Success(prod);
      }
    } catch (e) {
      print(
          "${response.statusCode} Error ProducerRepository ::  getAProducer :: $e ");
      errorMessage = "Erro do sistema";
    }
    return Failure(errorMessage ?? "Erro não esperado");
  }

  Future<Result<List<String>, String>> getTags() async {
    var response = await dio.get(
      "${Endpoints.baseUrl}${Endpoints.tags}",
    );
    try {
      if (response.statusCode == 200) {
        List<String> listTags = [];
        for (var element in response.data["tags"]) {
          listTags.add(element["name"]);
        }
        if (listTags.isEmpty) {
          throw Exception("Não há tags recebidas");
        }
        return Success(listTags);
      }
    } catch (e) {
      print(
          "${response.statusCode} Error ProducerRepository ::  getAProducer :: $e ");
      errorMessage = "Erro do sistema";
    }
    return const Failure("Não há tags a serem mostradas");
  }

  //function to see if all fields are completed in producer
  bool checkAllFieldsProducer(Producer producer) {
    if (producer.address != "" &&
        producer.contact != "" &&
        producer.opening_hours != "" &&
        producer.tags != null &&
        producer.lat != null &&
        producer.lng != null) {
      return true;
    }
    return false;
  }
}
