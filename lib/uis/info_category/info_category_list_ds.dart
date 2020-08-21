import 'package:flutter/material.dart';
import 'package:indis/models/info_category_model.dart';

class InfoCategoryListDS extends StatelessWidget {
  final List<InfoCategoryModel> infoCategoryList;
  final Function(String) onEditInfoCategoryCurrent;
  final Function(String) onTreeInfoCategoryCurrent;

  const InfoCategoryListDS({
    Key key,
    this.infoCategoryList,
    this.onEditInfoCategoryCurrent,
    this.onTreeInfoCategoryCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Minhas informações por categoria (${infoCategoryList.length})'),
      ),
      body: ListView.builder(
        itemCount: infoCategoryList.length,
        itemBuilder: (context, index) {
          final infoCategory = infoCategoryList[index];
          return Card(
            child: ListTile(
              selected: infoCategory?.public ?? false,
              title: Text('${infoCategory.name}'),
              // subtitle: Text('$infoCategory'),
              trailing: IconButton(
                icon: Icon(Icons.folder),
                onPressed: () {
                  onTreeInfoCategoryCurrent(infoCategory.id);
                },
              ),
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
