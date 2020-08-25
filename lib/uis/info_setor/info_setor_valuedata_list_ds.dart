import 'package:flutter/material.dart';
import 'package:indis/models/info_setor_model.dart';

class InfoSetorValueDataListDS extends StatelessWidget {
  final List<InfoSetorValueDataModel> valueDataList;
  final Function(String) onEditInfoSetorValueDataCurrent;

  const InfoSetorValueDataListDS({
    Key key,
    this.valueDataList,
    this.onEditInfoSetorValueDataCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${valueDataList.length} dados desta informação'),
      ),
      body: ListView.builder(
        itemCount: valueDataList.length,
        itemBuilder: (context, index) {
          final valueData = valueDataList[index];
          return Card(
            child: ListTile(
              title: Text('${valueData.period}'),
              subtitle: Text('${valueData.toMap()}'),
              onTap: () {
                onEditInfoSetorValueDataCurrent(valueData.id);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          onEditInfoSetorValueDataCurrent(null);
        },
      ),
    );
  }
}
