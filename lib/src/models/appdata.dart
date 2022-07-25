import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Este model contém uma classe que será responsável em fazer a requisição

//
class AppData with ChangeNotifier {
  // Esse Array vai armazenar o conteúdo da requisição
  var data = [];

  // Esse Array vai armazenar a cidade favorita selecionada e exibir uma lista na página cidades favoritas
  var favorites = [];

  // Gerando um Array com as informações das cidades favoritas
  List favoritesCities() {
    List result = [];
    for (var favorite in favorites) {
      List foundCities = this.searchCity(favorite);
      if (foundCities.length > 0) {
        result.add(foundCities[0]);
      }
    }

    return result;
  }

  // Essa função vai retornar uma lista de cidades correspondente a pequisa do usuário
  List searchCity(text) {
    List result = [];

    // tratando o texto de entrada pelo usuário
    // trim() remove os espaços desnecessários,
    text = text.trim().toLowerCase();

    // evitando a mostragem de todas as cidades no caso de ser enviado um texto vazio no input
    if (text == '') {
      return result;
    }

    // preenchendo o vetor result com todas as cidades correspondentes da pesquisa
    for (var continents in data) {
      for (var country in continents['countries']) {
        for (var city in country['cities']) {
          if (city['name'].toLowerCase().contains(text)) {
            result.add(city);
          }
        }
      }
    }

    return result;
  }

  // setData vai preencher o array com o resutado do request, que traz os
  // países, cidades e pontos turísticos
  void setData(newData) {
    data = newData;
    notifyListeners();
  }

  bool hasFavorite(cityName) {
    return favorites.contains(cityName);
  }

  bool favorite(cityName) {
    if (this.hasFavorite(cityName)) {
      favorites.remove(cityName);
      return false;
    } else {
      favorites.add(cityName);
      return true;
    }
  }

  // Função será assíncrona, por causa do delay da internet, que solicita o request
  // A função é acoplada ao tipo boleano, para utilizar o retorno da função
  // no momento de atribuir o valor da variável loading da page Preload
  // em true ou false variável
  Future<bool> requestData() async {
    final responseResquet =
        await http.get(Uri.parse('https://api.b7web.com.br/flutter1wb/'));

    if (responseResquet.statusCode == 200) {
      // Após responseRequest ser decodificada e transformada de fato em um objeto
      // pronto para manipulação, o usuário será mandado para a page Home
      setData(jsonDecode(responseResquet.body));
      return true;
    } else {
      return false;
    }
  }
}
