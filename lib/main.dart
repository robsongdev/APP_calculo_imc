import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // criando os controladores
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //criando chave global

  String _infoText = "Informe seus dados";

  void _resetFields() {
    weightController.text = ""; //.text para pegar o conteudo string
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
    });
  }

  void _calculate() {
    setState(() {
      double weight =
          double.parse(weightController.text); //tranformando string - double
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoText =
            "Abaixo do Peso (${imc.toStringAsPrecision(3)})"; //formatando os decimais
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            //botão no appbar
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _resetFields();
                })
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          //adicionar scrow
          // adicionar espaçamentos (left, top, right, botton)
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
              key: _formKey, //passando achave
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .stretch, // faz os elementos pegarem toda a largura não ser que seja especificado
                children: <Widget>[
                  Icon(Icons.person_outline, size: 120.0, color: Colors.green),
                  TextFormField(
                    //alterando para TextField para TextFormField
                    keyboardType: TextInputType
                        .number, // ao clicar vai aparecer apenas numero no teclado
                    decoration: InputDecoration(
                        //style = titulo da caixa de digitação
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    controller:
                        weightController, //ligando os controladores ao textfield
                    validator: (value) {
                      //validar conteudo "(value)""
                      if (value.isEmpty) {
                        return "Insira seu Peso";
                      }
                    },
                  ),
                  TextFormField(
                      keyboardType: TextInputType
                          .number, // ao clicar vai aparecer apenas numero no teclado
                      decoration: InputDecoration(
                          //style = titulo da caixa de digitação
                          labelText: "Altura (cm)",
                          labelStyle: TextStyle(color: Colors.green)),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 25.0),
                      controller: heightController,
                      validator: (value) {
                        //validar conteudo "(value)""
                        if (value.isEmpty) {
                          return "Insira seu Peso";
                        }
                      }),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height:
                          50, //botao dentro de um container para aumentar a altura
                      child: RaisedButton(
                          //botao com fundo
                          child: Text(
                            "Calcular",
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.0),
                          ),
                          color: Colors.green,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              //verificação ao apertar o botao
                              _calculate();
                            }
                          }),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                  )
                ],
              )),
        ));
  }
}
