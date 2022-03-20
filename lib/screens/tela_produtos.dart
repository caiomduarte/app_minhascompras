import 'package:app_minhascompras/model/Produtos.dart';


import 'package:flutter/material.dart';

import 'tela_cadastro.dart';
import 'util/ProdutosHelpers.dart';

class TelaProdutos extends StatefulWidget {
  //const TelaProdutos({ Key? key }) : super(key: key);

  @override
  _TelaProdutosState createState() => _TelaProdutosState();
}

class _TelaProdutosState extends State<TelaProdutos> {
  //1 Passo - é criar essa lista de objetos do tipo Produto
  List<Produtos> listadeprodutos = List<Produtos>();

  ProdutosHelpers db = ProdutosHelpers();

  TextEditingController txtnome =TextEditingController();
  TextEditingController txtfabricante =TextEditingController();
  TextEditingController txtpreco =TextEditingController();

  
  void recuperarProdutos() async {
    List produtosRecuperados = await db.listarProdutos();

    //print("Produtos cadastrados: " + produtosRecuperados.toString());

    //2 Passo - É converter os itens da lista produtosRecuperados, para a lista de objetos do tipo Produto
    List<Produtos> listatemporaria = List<Produtos>();

    for (var item in produtosRecuperados) {
      Produtos obj = Produtos.deMapParaModel(item);
      listatemporaria.add(obj);
    }

    setState(() {
      listadeprodutos = listatemporaria;
    });
  } // Fim do método recuperarProdutos

  //Metodo que remover um produto
  void removerProduto(int id) async {
    int resultado = await db.excluirProduto(id);
    
    
     recuperarProdutos();
  }


  void editarProduto(Produtos obj) async {

    obj.nome = txtnome.text;
    obj.fornecedor = txtfabricante.text;
    obj.preco = double.parse(txtpreco.text);

    int resultado = await db.alterarProduto(obj);

    if(resultado != null) {
      print("Dados alterados com sucesso");
    }else{
      print("Erro ao alterar os dados");
    }


  }



  void exibirtelaconfirma(int id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Excluir Produto"),
            content: Text("Você tem certeza que deseja excluir este Produto?"),
            backgroundColor: Colors.white,
            actions: [
              TextButton(
                  child: Text("SIM"),
                  onPressed: () {
                    print("Clicou no SIM DA CAIXA DE DIALOGO");
                    removerProduto(id);
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.redAccent)),
              TextButton(
                  child: Text("NÃO"),
                  onPressed: () {
                    print("Clicou no NÃO DA CAIXA DE DIALOGO");
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                      primary: Colors.white, backgroundColor: Colors.blueGrey)),
            ],
          );
        });
  }
  

  @override
  void initState() {
    super.initState();
    recuperarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Meus Produtos"),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: listadeprodutos.length,
                    itemBuilder: (context, index) {
                      final Produtos p = listadeprodutos[index];
                      return Card(
                        child: ListTile(
                            title: Text(
                              p.nome,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "R\$ " + p.preco.toString(),
                              style: TextStyle(fontSize: 15, color: Colors.red),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    exibirtelaconfirma(p.id);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print("Clicou no Editar!");
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> TelaCadastro(produto: p)));                                
       
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                )
                              ],
                            )),
                      );
                    }))
          ],
        ));
  }
}
