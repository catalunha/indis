import 'package:flutter/material.dart';
import 'package:indis/models/info_category_model.dart';
import 'package:indis/models/info_code_model.dart';
import 'package:indis/states/types_states.dart';

class InfoCodeSelectToInfoCategoryItemDS extends StatefulWidget {
  final List<InfoCodeModel> infoCodeList;
  final InfoCategoryItem categoryDataCurrent;
  final Function(InfoCodeModel, bool) onSetInfoCodeInInfoCategory;
  final Function(InfoCodeOrder) onSelectOrder;

  const InfoCodeSelectToInfoCategoryItemDS({
    Key key,
    this.onSetInfoCodeInInfoCategory,
    this.infoCodeList,
    this.categoryDataCurrent,
    this.onSelectOrder,
  }) : super(key: key);
  @override
  _InfoCodeSelectToInfoCategoryItemDSState createState() =>
      _InfoCodeSelectToInfoCategoryItemDSState();
}

class _InfoCodeSelectToInfoCategoryItemDSState
    extends State<InfoCodeSelectToInfoCategoryItemDS> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here

      child: Container(
        height: 700.0,
        width: 800.0,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  tooltip: 'Ordenar itens por Código',
                  icon: Icon(Icons.code),
                  onPressed: () {
                    widget.onSelectOrder(InfoCodeOrder.code);
                  },
                ),
                IconButton(
                  tooltip: 'Ordenar itens por Ordem alfabética',
                  icon: Icon(Icons.sort_by_alpha),
                  onPressed: () {
                    widget.onSelectOrder(InfoCodeOrder.name);
                  },
                ),
                IconButton(
                  tooltip: 'Ordenar itens por Unidade',
                  icon: Icon(Icons.format_underlined),
                  onPressed: () {
                    widget.onSelectOrder(InfoCodeOrder.unit);
                  },
                ),
                IconButton(
                  tooltip: 'Ordenar itens por Organizador',
                  icon: Icon(Icons.format_textdirection_r_to_l),
                  onPressed: () {
                    widget.onSelectOrder(InfoCodeOrder.infoIndOwnerRefName);
                  },
                ),
              ],
            ),
            Expanded(
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
                    subtitle: Text(
                        '${infoCode.name}\nUnidade: ${infoCode.unit}\nOrganizador: ${infoCode.infoIndOwnerRef.name}'),
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
          ],
        ),
      ),
    );
  }
}
