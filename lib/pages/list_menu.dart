import 'package:flutter/material.dart';
import 'package:responsi_prak/model/listmenu.dart';
import 'package:responsi_prak/pages/detail.dart';
import '../connections/api_source.dart';

class MealsPage extends StatelessWidget {
  final String param;
  const MealsPage({super.key, required this.param});

  @override
  Widget build( context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('$param Meals'),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: ApiDataSource.instance.getMeals(param),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              MenuModel data = MenuModel.fromJson(snapshot.data);
              return GridView.builder(
                itemCount: data.meals?.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2
                ),
                itemBuilder: (context, index) {
                  var meals = data.meals![index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(
                        builder: (context) => Details(id: meals.idMeal!),
                      )
                      );
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Image.network(
                            meals.strMealThumb!,
                            fit: BoxFit.fitHeight,
                            width: MediaQuery.sizeOf(context).width/3,
                          ),
                          const SizedBox(height: 10),
                          FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(meals.strMeal!)
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}