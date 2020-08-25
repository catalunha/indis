import 'package:flutter/material.dart';

class InfoSetorValueDataEditDS extends StatefulWidget {
  final String value;
  final int year;
  final int month;
  final String description;
  final bool isCreateOrUpdate;
  final Function(String, int, int, String, bool) onCreate;
  final Function(String, int, int, String, bool) onUpdate;

  const InfoSetorValueDataEditDS({
    Key key,
    this.value,
    this.description,
    this.isCreateOrUpdate,
    this.onCreate,
    this.onUpdate,
    this.year,
    this.month,
  }) : super(key: key);
  @override
  _InfoSetorValueDataEditDSState createState() =>
      _InfoSetorValueDataEditDSState();
}

class _InfoSetorValueDataEditDSState extends State<InfoSetorValueDataEditDS> {
  final formKey = GlobalKey<FormState>();

  int _year;
  int _month;
  List<String> _monthString = [
    'ano inteiro',
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro',
  ];
  String _value;
  String _description;
  bool _arquived = false;
  void validateSetor() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.isCreateOrUpdate
          ? widget.onCreate(_value, _year, _month, _description, _arquived)
          : widget.onUpdate(_value, _year, _month, _description, _arquived);
    } else {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _year = widget.year ?? 2020;
    _month = widget.month ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isCreateOrUpdate
            ? 'Criar valor nesta informação'
            : 'Editar valor nesta informação'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: form(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cloud_upload),
        onPressed: () {
          validateSetor();
        },
      ),
    );
  }

  Widget form() {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          TextFormField(
            initialValue: widget.value,
            decoration: InputDecoration(
              labelText: 'Informar valor',
            ),
            onSaved: (newValue) => _value = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          Row(
            children: [
              _month == 0
                  ? Text('Este valor se refere ao ')
                  : Text('Este valor se refere ao mês de '),
              IconButton(
                icon: Icon(Icons.arrow_upward),
                onPressed: () {
                  setState(() {
                    _month = _month < _monthString.length - 1 ? _month + 1 : 0;
                  });
                },
              ),
              Text(_monthString[_month]),
              IconButton(
                icon: Icon(Icons.arrow_downward),
                onPressed: () {
                  setState(() {
                    _month = _month > 0 ? _month - 1 : _monthString.length - 1;
                  });
                },
              ),
              Text('de '),
              IconButton(
                icon: Icon(Icons.arrow_upward),
                onPressed: () {
                  setState(() {
                    _year += 1;
                  });
                },
              ),
              Text(_year.toString()),
              IconButton(
                icon: Icon(Icons.arrow_downward),
                onPressed: () {
                  setState(() {
                    _year -= 1;
                  });
                },
              ),
            ],
          ),
          TextFormField(
            initialValue: widget.description,
            decoration: InputDecoration(
              labelText: 'Descrição do valor',
            ),
            onSaved: (newValue) => _description = newValue,
            validator: (value) {
              if (value.isEmpty) {
                return 'Informe o que se pede.';
              }
              return null;
            },
          ),
          SwitchListTile(
            value: _arquived,
            title: Text('Arquivar este valor ?'),
            onChanged: (value) {
              setState(() {
                _arquived = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
