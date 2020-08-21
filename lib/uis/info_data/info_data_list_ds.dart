import 'package:flutter/material.dart';
import 'package:indis/models/info_setor_model.dart';

class InfoDataListDS extends StatelessWidget {
  final List<InfoSetorModel> infoDataList;
  final Function(String) onEditInfoDataCurrent;

  const InfoDataListDS({
    Key key,
    this.infoDataList,
    this.onEditInfoDataCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista com ${infoDataList.length} município/setor'),
      ),
      body: ListView.builder(
        itemCount: infoDataList.length,
        itemBuilder: (context, index) {
          final infoData = infoDataList[index];
          return Card(
            child: ListTile(
              title: Text('${infoData.code}'),
              subtitle:
                  Text('${infoData.city}\n${infoData.description}\n$infoData'),
              onTap: () {
                onEditInfoDataCurrent(infoData.id);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          onEditInfoDataCurrent(null);
        },
      ),
    );
  }
}
