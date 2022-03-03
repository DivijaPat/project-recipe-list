import 'dart:convert';
import 'package:food_recipe/models/recipe.dart';
import 'package:http/http.dart'  as http;

class RecipeApi{

  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
    {"limit": "18", "start": "0"},
);
   
    final response = await http.get(uri, headers:{
     "x-rapidapi-host": "yummly2.p.rapidapi.com",
	   "x-rapidapi-key": "6fcac32142msh2a6f7265d215920p19acf9jsn36bc6fbb5ee7",
     "useQueryString": "true"
      });

    Map data = jsonDecode(response.body);
    List _temp = [];

    for(var i in data['feed']){
      _temp.add(i['content']['details']);
    }

    return Recipe.recipesFromSnapshot(_temp);

  }
}