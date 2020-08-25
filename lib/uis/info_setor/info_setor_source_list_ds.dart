import 'package:flutter/material.dart';
import 'package:indis/models/info_setor_model.dart';

class InfoSetorSourceListDS extends StatelessWidget {
  final List<InfoSetorSourceModel> sourceMap;
  final Function(String) onEditInfoSetorSourceCurrent;

  const InfoSetorSourceListDS({
    Key key,
    this.sourceMap,
    this.onEditInfoSetorSourceCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${sourceMap.length} fontes'),
      ),
      body: ListView.builder(
        itemCount: sourceMap.length,
        itemBuilder: (context, index) {
          final source = sourceMap[index];
          return Card(
            child: ListTile(
              title: Text('${source.name}'),
              subtitle: Text('${source.toString()}'),
              onTap: () {
                onEditInfoSetorSourceCurrent(source.id);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          onEditInfoSetorSourceCurrent(null);
        },
      ),
    );
  }
}
