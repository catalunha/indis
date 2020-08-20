import 'package:flutter/material.dart';
import 'package:indis/states/types_states.dart';

class InfoCodeOrderingDS extends StatelessWidget
    with _InfoCodeOrderingDSComponents {
  final InfoCodeOrder infoCodeOrder;
  final Function(InfoCodeOrder) onSelectOrder;

  InfoCodeOrderingDS({Key key, this.infoCodeOrder, this.onSelectOrder})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<InfoCodeOrder>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      icon: popupIcon(infoCodeOrder),
      tooltip: 'Ordenar informação por',
      onSelected: (value) => onSelectOrder(value),
      itemBuilder: (context) => <PopupMenuItem<InfoCodeOrder>>[
        PopupMenuItem<InfoCodeOrder>(
          value: InfoCodeOrder.code,
          child: Row(
            children: [
              codeIcon,
              SizedBox(width: 5),
              Text(InfoCodeOrder.code.label),
            ],
          ),
        ),
        PopupMenuItem<InfoCodeOrder>(
          value: InfoCodeOrder.name,
          child: Row(
            children: [
              nameIcon,
              SizedBox(width: 5),
              Text(InfoCodeOrder.name.label),
            ],
          ),
        ),
        PopupMenuItem<InfoCodeOrder>(
          value: InfoCodeOrder.unit,
          child: Row(
            children: [
              unitIcon,
              SizedBox(width: 5),
              Text(InfoCodeOrder.unit.label),
            ],
          ),
        ),
        PopupMenuItem<InfoCodeOrder>(
          value: InfoCodeOrder.infoIndOwnerCode,
          child: Row(
            children: [
              infoIndOwnerCodeIcon,
              SizedBox(width: 5),
              Text(InfoCodeOrder.infoIndOwnerCode.label),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoCodeOrderingDSComponents {
  final codeIcon = Icon(Icons.code);
  final nameIcon = Icon(Icons.sort_by_alpha);
  final unitIcon = Icon(Icons.format_underlined);
  final infoIndOwnerCodeIcon = Icon(Icons.format_textdirection_r_to_l);
  Icon popupIcon(InfoCodeOrder infoCodeOrder) {
    var icon = codeIcon;
    if (infoCodeOrder == InfoCodeOrder.name) {
      icon = nameIcon;
    } else if (infoCodeOrder == InfoCodeOrder.unit) {
      icon = unitIcon;
    } else if (infoCodeOrder == InfoCodeOrder.infoIndOwnerCode) {
      icon = infoIndOwnerCodeIcon;
    }
    return icon;
  }
}
