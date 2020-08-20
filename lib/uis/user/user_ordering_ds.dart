import 'package:flutter/material.dart';
import 'package:indis/states/types_states.dart';

class UserOrderingDS extends StatelessWidget with _UserOrderingDSComponents {
  final UserOrder userOrder;
  final Function(UserOrder) onSelectOrder;

  UserOrderingDS({Key key, this.userOrder, this.onSelectOrder})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<UserOrder>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      icon: popupIcon(userOrder),
      tooltip: 'Ordenar usuário por',
      onSelected: (value) => onSelectOrder(value),
      itemBuilder: (context) => <PopupMenuItem<UserOrder>>[
        PopupMenuItem<UserOrder>(
          value: UserOrder.name,
          child: Row(
            children: [
              nameIcon,
              SizedBox(width: 5),
              Text(UserOrder.name.label),
            ],
          ),
        ),
      ],
    );
  }
}

class _UserOrderingDSComponents {
  final sispatIcon = Icon(Icons.format_list_numbered);
  final nameIcon = Icon(Icons.sort_by_alpha);
  final plataformRefOnBoardIcon = Icon(Icons.directions_boat);
  final dateTimeOnBoardIcon = Icon(Icons.date_range);
  Icon popupIcon(UserOrder userOrder) {
    var icon = sispatIcon;
    if (userOrder == UserOrder.name) {
      icon = nameIcon;
    }
    return icon;
  }
}
