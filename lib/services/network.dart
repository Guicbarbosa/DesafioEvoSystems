// Bibliotecas importadas
import 'package:http/http.dart' as http;
import 'dart:convert';

// Definição da classe
class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    // Busca os dados na url que foi passada
    http.Response response = await http.get(url);
    
    // Verifica se o código de resposta foi 200 (código http para sucesso)
    if (response.statusCode == 200) {
      String data = response.body; // Pega o conteudo retornado 

      return jsonDecode(data); // Retorna o corpo da resposta no formato json
    } else {
      print(response.statusCode); // se tiver dado errado ele retorna o código http do erro
    }
  }
}