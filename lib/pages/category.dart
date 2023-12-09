import 'package:responsi_prak/connections/api_source.dart';
import 'package:responsi_prak/model/CatModel.dart';
import 'package:flutter/material.dart';
import 'package:responsi_prak/pages/list_menu.dart';

class ListMenu extends StatefulWidget {
  const ListMenu({Key? key}) : super(key: key);

  @override
  State<ListMenu> createState() => _ListMenuState();
}

class _ListMenuState extends State<ListMenu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.deepOrangeAccent
      ),
      title: 'Kategori Makanan',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Kategori Menu Makanan"),
        ),
        body: _buildListUsersBody(),
      ),
    );
  }

  Widget _buildListUsersBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadMenu(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            ModelCategory className = ModelCategory.fromJson(snapshot.data);
            return _buildSuccessSection(className);
          }
          return _buildLoadingSection();
        },
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

  Widget _buildSuccessSection(ModelCategory Categories) {
    return ListView.builder(
      itemCount: Categories.categories!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemUsers(Categories.categories![index]);
      },
    );
  }

  Widget _buildItemUsers(Categories list) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MealsPage(param: list.strCategory!),
            ));
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipPath(
                clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Image.network(
                  list.strCategoryThumb!,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                list.strCategory!,
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  list.strCategoryDescription!,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}