import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Recipe {
  final String title;
  final String description;
  final List<String> ingredients;

  Recipe({
    required this.title,
    required this.description,
    required this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'],
      description: json['description'],
      ingredients: List<String>.from(json['ingredients']),
    );
  }
}

class RecipeList {
  final List<Recipe> recipes;

  RecipeList({required this.recipes});

  factory RecipeList.fromJson(Map<String, dynamic> json) {
    final List<dynamic> recipeList = json['recipes'];
    final List<Recipe> recipes = recipeList
        .map((dynamic recipeJson) => Recipe.fromJson(recipeJson))
        .toList();

    return RecipeList(recipes: recipes);
  }
}

class RecipeListView extends StatelessWidget {
  final String jsonString = '''
  {
    "recipes": [
      {
        "title": "Pasta Carbonara",
        "description": "Creamy pasta dish with bacon and cheese.",
        "ingredients": ["spaghetti", "bacon", "egg", "cheese"]
      },
      {
        "title": "Caprese Salad",
        "description": "Simple and refreshing salad with tomatoes, mozzarella, and basil.",
        "ingredients": ["tomatoes", "mozzarella", "basil"]
      },
      {
        "title": "Banana Smoothie",
        "description": "Healthy and creamy smoothie with bananas and milk.",
        "ingredients": ["bananas", "milk"]
      },
      {
        "title": "Chicken Stir-Fry",
        "description": "Quick and flavorful stir-fried chicken with vegetables.",
        "ingredients": ["chicken breast", "broccoli", "carrot", "soy sauce"]
      },
      {
        "title": "Grilled Salmon",
        "description": "Delicious grilled salmon with lemon and herbs.",
        "ingredients": ["salmon fillet", "lemon", "olive oil", "dill"]
      },
      {
        "title": "Vegetable Curry",
        "description": "Spicy and aromatic vegetable curry.",
        "ingredients": ["mixed vegetables", "coconut milk", "curry powder"]
      },
      {
        "title": "Berry Parfait",
        "description": "Layered dessert with fresh berries and yogurt.",
        "ingredients": ["berries", "yogurt", "granola"]
      }
    ]
  }
  ''';

  const RecipeListView({super.key});

  RecipeList parseRecipes(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return RecipeList.fromJson(json);
  }

  @override
  Widget build(BuildContext context) {
    final RecipeList recipeList = parseRecipes(jsonString);
    return ListView.builder(
      itemCount: recipeList.recipes.length,
      itemBuilder: (BuildContext context, int index) {
        final Recipe recipe = recipeList.recipes[index];
        return ListTile(
          leading: const Icon(Icons.image),
          title: Text(recipe.title),
          subtitle: Text(recipe.description),
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Recipes'),
        ),
        body: const RecipeListView(),
      ),
    );
  }
}