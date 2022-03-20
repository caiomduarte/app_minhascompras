import 'dart:io';

import 'package:app_minhascompras/model/Produtos.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ProdutosHelpers {

//Atributos 
static Database _database;
static ProdutosHelpers _databasehelper;

ProdutosHelpers._createInstance(); 

factory ProdutosHelpers(){

 if(_databasehelper == null){
   _databasehelper = ProdutosHelpers._createInstance();
 }

 return _databasehelper;

}


//Defini a estrutura da nossa tabela
  String nomeTabela = 'tb_produtos';
  String colunaId = 'id';
  String colunaNome = 'nome';
  String colunaForn = 'fornecedor';
  String colunapreco = 'preco';

  //1 Passo - Metodo que cria o banco de dados
  void _criarBanco(Database db, int version) async {
    String sql = """CREATE TABLE $nomeTabela(
                      $colunaId INTEGER PRIMARY KEY AUTOINCREMENT,
                      $colunaNome Text,
                      $colunaForn Text,
                      $colunapreco float
                    )   
                 """;

    await db.execute(sql);
  }

 //2 passo - Criar o metodo que inicializa o banco de dados
  Future<Database> inicializaBanco() async {
    
    // Pega o caminho do android ou do ios para salvar o banco de dados
    Directory directory = await getApplicationDocumentsDirectory();
    String caminho = directory.path + 'bdprodutos.bd';

    var bancodedados = await openDatabase(caminho, version: 1, onCreate: _criarBanco);

    return bancodedados;
  }


//3 passo - Criar o metodo que verifica se o banco foi inicializado
Future<Database> get database async{
  
  if(_database == null){
    _database = await inicializaBanco();
  }

  return _database;

}


//Métodos CRUD
//create, read, update e delete produtos

//Metodo CadastrarProdutos
Future<int> cadastraProduto(Produtos obj) async{

  //1 passo - Selecionar o banco
  Database db = await this.database;
  
  var resposta = await db.insert(nomeTabela, obj.toMap());

  return resposta;

}


//Método listarProdutos

listarProdutos() async {

  //1 passo - Selecionar o banco
  Database db = await this.database;

  //2 Passo - Definir o comando SQL
  String sql = "select * from $nomeTabela";

  //3 Passo - Criar uma lista para armazenar os itens, e executa o comando
  List lista = await db.rawQuery(sql);

  //4 passo  retorna essa lista
  return lista;

}


//Método Excluir Produto
//delete from tbprodutos where id = 5
Future<int> excluirProduto(int id) async {

  //1 passo - Selecionar o banco
  Database db = await this.database;

  var resultado  = await db.delete(nomeTabela, where: "id = ?", whereArgs: [id]);

  return resultado;
}


//Método Alterar Produto
//update from tbprodutos set nome = leite desnatado, preco=20 where id = 5
Future<int> alterarProduto(Produtos obj) async {
 
 //1 passo - Selecionar o banco
  Database db = await this.database;

  var resultado = await db.update(nomeTabela, obj.toMap(), where: "id = ?", whereArgs: [obj.id]);
  print(resultado);
  return resultado;

}


} //Fecha a classe ProdutosHelpers