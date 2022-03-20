
class Produtos {


//Atributos

int id;
String nome;
String fornecedor; 
double preco;

//Construtor
Produtos(this.id, this.nome, this.fornecedor, this.preco);




//Métodos

//FLUXO DE IDA
//Método que CONVERTER UM MODEL PARA MAP
Map<String, dynamic> toMap(){
  
  //1 passo - é criar o map que vai ser retornado
  var dados = Map<String, dynamic>();

  //2 passo - é guardar os dados dos atributos no map
  dados['id'] = id;
  dados['nome'] = nome;
  dados['fornecedor'] = fornecedor;
  dados['preco'] = preco;

  return dados;
}



//FLUXO DE VOLTA
//Método que CONVERTER DE MAP PARA MODEL
Produtos.deMapParaModel(Map<String, dynamic> dados){
  
  this.id = dados['id'];
  this.nome = dados['nome'];
  this.fornecedor = dados['fornecedor'];
  this.preco = dados['preco'];

}




}