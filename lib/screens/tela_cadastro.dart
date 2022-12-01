import 'package:app_minhascompras/model/Produtos.dart';
import 'package:app_minhascompras/screens/home.dart';
import 'package:app_minhascompras/screens/util/ProdutosHelpers.dart';

import 'package:flutter/material.dart';

class TelaCadastro extends StatefulWidget {
  @override
  _TelaCadastroState createState() => _TelaCadastroState();

  Produtos? produto;

  //Definindo um construtor para a classe TelaCadastro
  TelaCadastro({this.produto});
}

class _TelaCadastroState extends State<TelaCadastro> {
  TextEditingController txtnome = TextEditingController();
  TextEditingController txtfornecedor = TextEditingController();
  TextEditingController txtpreco = TextEditingController();

  ProdutosHelpers db = ProdutosHelpers();

  String textoBotao = "Adicionar um Produto";
  String textoAppbar = "Cadastro de Produto";

  int? idproduto;

  void salvarProduto({Produtos? p}) async {
    int resultado;

    //Esta cadastrando um novo produto
    if (p == null) {
      //1 Passo - Criar o objeto Model para pegar os dados da tela
      Produtos obj = Produtos(
          null, txtnome.text, txtfornecedor.text, double.parse(txtpreco.text));

      resultado = await db.cadastraProduto(obj);
      print(resultado);
      if (resultado != null) {
        //Exibindo uma mensagem com Snackbar
        final SnackBar snackBar = SnackBar(
          content: Text("Produto cadastrado com sucesso!"),
          duration: Duration(seconds: 5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        //Voltando para a tela Hoje
        Navigator.pop(context);
      }
    }

    //Estar alterando um produto
    else {
      //1 passo - pegar os dados e monta o objeto para alterar
      p.nome = txtnome.text;
      p.fornecedor = txtfornecedor.text;
      p.preco = double.parse(txtpreco.text);
      p.id = idproduto;

      resultado = await db.alterarProduto(p);
      print("ALterado com sucesso! " + resultado.toString());

      //Ela abre a tela de home
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.produto != null) {
      txtnome.text = widget.produto!.nome!;
      txtfornecedor.text = widget.produto!.fornecedor!;
      txtpreco.text = widget.produto!.preco.toString();

      idproduto = widget.produto!.id;

      textoBotao = "Editar Produto";
      textoAppbar = "Editar Produto";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(textoAppbar),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: null,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextFormField(
                      controller: txtnome,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(labelText: "Alimento"),
                      style: TextStyle(fontSize: 20)),
                  TextFormField(
                      controller: txtfornecedor,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(labelText: "Fornecedor"),
                      style: TextStyle(fontSize: 20)),
                  TextFormField(
                      controller: txtpreco,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(labelText: "Preço"),
                      style: TextStyle(fontSize: 20)),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(textoBotao),
                      onPressed: () {
                        salvarProduto(p: widget.produto);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey, onPrimary: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
