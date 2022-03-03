import 'package:flutter/material.dart';
import 'package:food_recipe/models/recipe.api.dart';
import 'package:food_recipe/models/recipe.dart';
import 'package:food_recipe/views/widgets/recipe_card.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Recipe> _recipes;
  bool _isloading = true;

  @override
  void initState() {
    super.initState();

    getRecipes();
  }

   
    Future<void> getRecipes() async{
      _recipes = await RecipeApi.getRecipe();
      setState(() {
        _isloading = false;
      });
    }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(Icons.restaurant_menu),
          SizedBox(width: 10),
          Text('Food Recipe')
        ],),
      ),
      body:_isloading ? 
      Center(child: CircularProgressIndicator()) 
      :ListView.builder(
        itemCount: _recipes.length,
        itemBuilder: (BuildContext context, int index) {  
          return RecipeCard(
            title: _recipes[index].name,
             cookTime: _recipes[index].totalTime, 
             rating: _recipes[index].rating.toString(), 
             thumbnailUrl: _recipes[index].images);
        },
        )
      );
  }
}