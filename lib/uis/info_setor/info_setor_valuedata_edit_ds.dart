import 'package:flutter/material.dart';

class InfoSetorValueDataEditDS extends StatefulWidget {
  final String value;
  final String description;
  final bool isCreateOrUpdate;
  final Function(String, String, bool) onCreate;
  final Function(String, String, bool) onUpdate;

  const InfoSetorValueDataEditDS({
    Key key,
    this.value,
    this.description,
    this.isCreateOrUpdate,
    this.onCreate,
    this.onUpdate,
  }) : super(key: key);
  @override
  _InfoSetorValueDataEditDSState createState() =>
      _InfoSetorValueDataEditDSState();
}

class _InfoSetorValueDataEditDSState extends State<InfoSetorValueDataEditDS> {
  final formKey = GlobalKey<FormState>();

  int _year = 2020;
  int _monthIndex = 0;
  List<String> _month = [
    'Ano inteiro',
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
          ? widget.onCreate(_value, _description, _arquived)
          : widget.onUpdate(_value, _description, _arquived);
    } else {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
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
              _monthIndex == 0
                  ? Text('Este valor se refere ao ')
                  : Text('Este valor se refere ao mês de '),
              IconButton(
                icon: Icon(Icons.arrow_upward),
                onPressed: () {
                  setState(() {
                    _monthIndex =
                        _monthIndex < _month.length - 1 ? _monthIndex + 1 : 0;
                  });
                },
              ),
              Text(_month[_monthIndex]),
              IconButton(
                icon: Icon(Icons.arrow_downward),
                onPressed: () {
                  setState(() {
                    _monthIndex =
                        _monthIndex > 0 ? _monthIndex - 1 : _month.length - 1;
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
