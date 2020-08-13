import 'package:flutter/material.dart';
import 'package:indis/models/info_category_model.dart';

class InfoCategoryListDS extends StatelessWidget {
  final List<InfoCategoryModel> infoCategoryList;
  final Function(String) onEditInfoCategoryCurrent;

  const InfoCategoryListDS({
    Key key,
    this.infoCategoryList,
    this.onEditInfoCategoryCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${infoCategoryList.length} categorias'),
      ),
      body: ListView.builder(
        itemCount: infoCategoryList.length,
        itemBuilder: (context, index) {
          final infoCategory = infoCategoryList[index];
          return Card(
            child: ListTile(
              title: Text('${infoCategory.name}'),
              subtitle:
                  Text('${infoCategory.infoCategoryRef?.toMap() ?? null}'),
              onTap: () {
                onEditInfoCategoryCurrent(infoCategory.id);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          onEditInfoCategoryCurrent(null);
        },
      ),
    );
  }
}
