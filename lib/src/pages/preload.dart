import 'package:flutter/material.dart';

// Para trabalhar o layout da Status Bar foi interessante utilizar os recursos do
// pacote services
import 'package:flutter/services.dart';

// Utilizando o provider AppData
import 'package:provider/provider.dart';
import '../models/appdata.dart';

class PreloadPage extends StatefulWidget {
  @override
  _PreloadPage createState() => _PreloadPage();
}

class _PreloadPage extends State<PreloadPage> {
  bool loading = true;

  // Função para solicitar o provider AppData e setar, true ou false, na variável loading
  // função do tipo Void por não retornar nada
  void requestInfo() async {
    // Para correção do erro, da função initSate, foi gerado um delay na execução da requestInfo
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      loading = true;
    });

    bool requestAppData =
        await Provider.of<AppData>(context, listen: false).requestData();

    if (requestAppData) {
      // objeto criado pelo jsonDecode em appData o usuário será mandando para
      // a page home
      // ReplacementName tira a opção de voltar a tela do preload
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  // Como a classe PreloadPage é do tipo Stateful é necessário executar
  // a função initState para rodar apenas uma vez e não ficar executando todo
  // momento que houver alguma mudança na page
  //// uma função do tipo initState será executada antes da renderização da página
  /// e isso gera um erro, pois, a variável loading não está atribuida com o valor
  /// correspondente para dar sequência a renderização do app
  void initState() {
    // para executar de forma global é usado o tipo Super
    super.initState();

    requestInfo();
  }

  @override
  Widget build(BuildContext context) {
    // estilizando as fontes do Status Bar (infos do cell: hora, wifi,
    // porcentagem da bateria, tudo o que for relacionado os status das
    // informações do celular)
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 20),
            child: Image.asset(
              // para excutar no chrome
              // '../../lib/assets/devstravel_logo.png',

              // para executar no celular
              'lib/assets/devstravel_logo.png',

              // para executar no celular
              width: MediaQuery.of(context).size.width * 0.6,

              // para executar no chrome
              // width: MediaQuery.of(context).size.width * 0.3,
            ),
          ),
          loading
              ? Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: Text(
                    'Carregando informações...',
                    style: TextStyle(fontSize: 16),
                  ))
              : Container(),
          loading
              ? CircularProgressIndicator(
                  strokeWidth: 4,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                )
              : Container(),
          !loading
              ? Container(
                  margin: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 37, 122, 80), // background
                      onPrimary: Colors.white, // foreground
                    ),
                    child: Text('Tentar Novamente'),
                    onPressed: () {},
                  ),
                )
              : Container(),
        ],
      )),
    );
  }
}
