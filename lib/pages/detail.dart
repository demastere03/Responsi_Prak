import 'package:flutter/material.dart';
import 'package:responsi_prak/model/detailmodel.dart';
import '../connections/api_source.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatelessWidget {
  final String id;
  const Details({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.purple
      ),
      debugShowCheckedModeBanner: false,
      title: 'Menu Details',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Menu Details"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: ApiDataSource.instance.getDetails(id),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                // Jika data ada error maka akan ditampilkan hasil error
                return _buildErrorSection();
              }
              if (snapshot.hasData) {
                // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
                TeriyakiDetail className = TeriyakiDetail.fromJson(snapshot.data);
                return _buildSuccessSection(className);
              }
              return _buildLoadingSection();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(TeriyakiDetail Meals) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: Meals.meals!.length,
      itemBuilder: (BuildContext context, int index) {
        if (Meals.meals![index].idMeal == id) {
          return _buildItemUsers(Meals.meals![index]);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildItemUsers(Meals data) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff1a1e2d), Color(0xff8a001c)],
              stops: [0.2, 0.87],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      data.strMealThumb??'',
                      width: 200,
                      height: 200,
                    ),
                    SizedBox(height: 10),
                    Text(
                      data.strMeal??'',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ingredients You Need',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(data.strIngredient1 ?? ''),
                    Text(data.strIngredient2 ?? ''),
                    Text(data.strIngredient3 ?? ''),
                    Text(data.strIngredient4 ?? ''),
                    Text(data.strIngredient5 ?? ''),
                    Text(data.strIngredient6 ?? ''),
                    Text(data.strIngredient7 ?? ''),
                    Text(data.strIngredient8 ?? ''),
                    Text(data.strIngredient9 ?? ''),
                    Text(data.strIngredient10 ?? ''),
                    Text(data.strIngredient11 ?? ''),
                    Text(data.strIngredient12 ?? ''),
                    Text(data.strIngredient13 ?? ''),
                    Text(data.strIngredient14 ?? ''),
                    Text(data.strIngredient15 ?? ''),
                    Text('Instructions',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(data.strInstructions??''),
                  ],
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  launchUrl(Uri.parse(data.strYoutube??''));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50)
                ),
                child: const Row(
                  children: [
                    Icon(Icons.play_arrow),
                    Text('Watch Tutorial'),
                  ],
                )
            )
          ],
        ));
  }
}
