import 'package:flutter/material.dart';
import 'package:indis/models/info_category_model.dart';
import 'package:indis/models/info_code_model.dart';

class InfoCodeSelectDS extends StatefulWidget {
  final List<InfoCodeModel> infoCodeList;
  final InfoCategoryItem categoryDataCurrent;
  final Function(InfoCodeModel, bool) onSetInfoCodeInInfoCategory;

  const InfoCodeSelectDS({
    Key key,
    this.onSetInfoCodeInInfoCategory,
    this.infoCodeList,
    this.categoryDataCurrent,
  }) : super(key: key);
  @override
  _InfoCodeSelectDSState createState() => _InfoCodeSelectDSState();
}

class _InfoCodeSelectDSState extends State<InfoCodeSelectDS> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 700.0,
        width: 800.0,
        child: ListView.builder(
          itemCount: widget.infoCodeList.length,
          itemBuilder: (context, index) {
            final infoCode = widget.infoCodeList[index];

            return ListTile(
              selected: widget.categoryDataCurrent.infoCodeRefMap != null
                  ? widget.categoryDataCurrent.infoCodeRefMap
                      .containsKey(infoCode.id)
                  : false,
              title: Text('${infoCode.code}'),
              subtitle: Text('${infoCode.name}\nworkerModel: $infoCode'),
              onTap: () {
                widget.onSetInfoCodeInInfoCategory(
                    infoCode,
                    !(widget.categoryDataCurrent.infoCodeRefMap != null
                        ? widget.categoryDataCurrent.infoCodeRefMap
                            .containsKey(infoCode.id)
                        : false));
                setState(() {});
              },
            );
          },
        ),
      ),
    );
  }
}
