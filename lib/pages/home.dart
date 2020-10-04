import 'package:flutter/material.dart';
import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Band> bands = [
    Band(id: '1', name: 'Heroes del silencio', votes: 50),
    Band(id: '2', name: 'Bon Jovi', votes: 20),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Band Names',
          style: TextStyle(color: Colors.black87),
        )),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) {
          return bandListTile(bands[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
    );
  }

  addNewBand() {
    final textController = new TextEditingController();

    return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
              title: Text('Add New Band:'),
              content: TextField(
                controller: textController,
              ),
              actions: <Widget> [
                MaterialButton(
                    child: Text('Add'),
                    textColor: Colors.blue,
                    color: Colors.blue[100],
                    elevation: 5,
                    onPressed: () => addBandToList(textController.text))
              ],
        )
    );
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      this.bands.add(
        new Band(
          id: DateTime.now().toString(), 
          name: name, 
          votes: 5
        )
      );

      setState(() {});
    }
    Navigator.of(context).pop();
  }

   Widget bandListTile(Band band) {
    return Dismissible(
          key: Key(band.id),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {
            
            print('direction: $direction');
            print('${ band.name } dimissed');
            
            //TODO: manejar con el backend

          },
          background: Container(color: Colors.red),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(band.name.substring(0, 2)),
              backgroundColor: Colors.blue[100],
            ),
          title: Text(band.name),
          trailing: Text('${band.votes}'),
          onTap: () => print(band.name),
          ),
    );
  }
}
