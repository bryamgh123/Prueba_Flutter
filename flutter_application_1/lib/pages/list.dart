import 'package:flutter/material.dart';
import 'package:flutter_application_1/db/operation.dart';
import 'package:flutter_application_1/models/note.dart';
import 'package:flutter_application_1/pages/save.dart';
import 'package:flutter_application_1/pages/graficas.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);
  static const String ROUTE = "/";

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return _MyList();
  }
}

class _MyList extends StatefulWidget {
  @override
  State<_MyList> createState() => _MyListState();
}

class _MyListState extends State<_MyList> {
  List<Note> notes = [];

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tareas"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, SavePage.ROUTE,
                      arguments: Note.empty())
                  .then((value) {
                setState(() {
                  _loadData();
                });
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.show_chart),
            onPressed: () {
              Navigator.pushNamed(context, GraficasPage.ROUTE).then((value) {
                setState(() {
                  _loadData();
                });
              });
            },
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (_, i) => _createItem(i),
        ),
      ),
    );
  }

  _loadData() async {
    // Creo un listado temporal para las tareas
    List<Note> auxNotes = await Operation.notes();

    setState(() {
      notes = auxNotes;
    });
  }

  _createItem(int i) {
    return Dismissible(
        key: Key(notes[i].id.toString()),
        direction: DismissDirection.startToEnd,
        background: Container(
          color: Colors.red,
          padding: EdgeInsets.only(left: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
        onDismissed: (direction) {
          Operation.delete(context, notes[i]).then((_) {
            // Actualizar la lista después de eliminar la nota
            _loadData();
          });
        },
        child: ListTile(
          title: Text(notes[i].title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.pushNamed(context, SavePage.ROUTE,
                          arguments: notes[i])
                      .then((value) => setState(() {
                            _loadData();
                          }));
                },
              ),
              IconButton(
                icon: Icon(Icons.check),
                //color: notes[i].completed == true ? Colors.green : null,
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    //     notes[i].completed = true;
                    Operation.update(context, notes[i]).then((_) {
                      _loadData();
                    });
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.close),
                // color: notes[i].completed == false ? Colors.red : null,
                splashColor: Colors.red,
                onPressed: () {
                  setState(() {
                    //      notes[i].completed = true;
                    Operation.update(context, notes[i]).then((_) {
                      _loadData();
                    });
                  });
                },
              ),
            ],
          ),
        ));
  }
}

void main() {
  runApp(MaterialApp(
    home: ListPage(),
  ));
}
