import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myapp/infrastructure/models/pokemon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen>{
  Pokemon? pokemon;
  int pokemonId = 0;
  @override
  void initState() {
    super.initState();
    getPokemon();
  }


  Future<void> getPokemon() async {
    pokemonId++;
    final response = await Dio().get("https://pokeapi.co/api/v2/pokemon/$pokemonId");
    pokemon = Pokemon.fromJson(response.data);
    setState(() {
      
    });
  }

  Future<void> getLastPokemon() async {
    if(pokemonId != 1){
      
      pokemonId--;
      final response = await Dio().get("https://pokeapi.co/api/v2/pokemon/$pokemonId");
      pokemon = Pokemon.fromJson(response.data);
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(pokemon?.name ?? 'No data', style: const TextStyle(fontSize: 35.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Type(s): ", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                Text(pokemon?.types[0].type.name ?? "", style: const TextStyle(fontSize: 25.0),),
                const Text("\t\t\t\t\t"),
                
                if(pokemon?.types.length == 2)
                  Text(pokemon?.types[1].type.name ?? "", style: const TextStyle(fontSize: 25.0)),
              ],
              
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              if(pokemon != null)
                ...[
                  Image.network(pokemon!.sprites.frontDefault),
                  Image.network(pokemon!.sprites.backDefault),
                ],
              ],
            )
            
          ],
          
        ),
      ),
        

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.navigate_before),
            onPressed: () {
              getLastPokemon();
            },
          ),
          

          FloatingActionButton(
            child: const Icon(Icons.navigate_next),
            onPressed: () {
              getPokemon();
            },
            
          ),
        ],
      ),

    );
  }
}