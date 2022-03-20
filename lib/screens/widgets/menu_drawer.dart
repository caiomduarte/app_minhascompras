
import 'package:app_minhascompras/screens/tela_cadastro.dart';
import 'package:app_minhascompras/screens/tela_produtos.dart';
import 'package:flutter/material.dart';

Widget menuDrawer(BuildContext context){
  return Drawer(
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(40),
          width: double.infinity,
          height: 230,
          color: Colors.blueGrey,
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top:10),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage("https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944_960_720.jpg"),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                SizedBox(height: 10,),
               
                Text("Minha Lista de compras", style: TextStyle(fontSize: 18, color: Colors.white),),
                
                SizedBox(height: 10,),
               
                Text("Desenvolvido por Caio Malheiros", style: TextStyle(fontSize: 12, color: Colors.white),)
              ],
            ),
          ),
        ),
        ListTile(
          leading:  Icon(Icons.add, color: Colors.blueGrey,),
          title: Text("Novo produto", style: TextStyle(fontSize: 16)),
          onTap: (){
            print("Clicou no menu Novo Produto");
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context)=> TelaCadastro()));
          },
        ),
        ListTile(
          leading:  Icon(Icons.food_bank, color: Colors.blueGrey,),
          title: Text("Meus produtos", style: TextStyle(fontSize: 16)),
          onTap: (){
             Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context)=> TelaProdutos()));
          },
        )
      ],
    ),

  );
}