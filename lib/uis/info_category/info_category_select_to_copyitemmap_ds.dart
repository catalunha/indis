import 'package:flutter/material.dart';
import 'package:indis/models/info_category_model.dart';

class InfoCategorySelectToCopyItemMapDS extends StatelessWidget {
  final List<InfoCategoryModel> infoCategoryListToCopyItemMap;
  final Function(InfoCategoryModel) onSetCopyItemMapInInfoCategory;

  const InfoCategorySelectToCopyItemMapDS({
    Key key,
    this.infoCategoryListToCopyItemMap,
    this.onSetCopyItemMapInInfoCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 300.0,
        width: 400.0,
        child: ListView.builder(
          itemCount: infoCategoryListToCopyItemMap.length,
          itemBuilder: (context, index) {
            final infoCategory = infoCategoryListToCopyItemMap[index];
            return ListTile(
              title: Text('${infoCategory?.name}'),
              subtitle: Text(
                  'Quantidade de categorias: ${infoCategory?.itemMap?.length}\nDescrição: ${infoCategory?.description}\nAutor: ${infoCategory?.userRef?.name}'),
              onTap: () {
                onSetCopyItemMapInInfoCategory(infoCategory);
              },
            );
          },
        ),
      ),
    );
  }
}
