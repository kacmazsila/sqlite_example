import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path/path.dart';

import '../model/notes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtDetail = TextEditingController();
  List<Notes> lstNotes = <Notes>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notlarım"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                controller: txtTitle,
                decoration: const InputDecoration(
                    label: Text('Başlık'), border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                controller: txtDetail,
                decoration: const InputDecoration(
                    label: Text('Detay'), border: OutlineInputBorder()),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: saveNote(),
                  child: const Text('Kaydet'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                ),
                ElevatedButton(
                  onPressed: updateNote,
                  child: const Text('Güncelle'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: lstNotes.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {},
                        title: Text(lstNotes[index].title!),
                        subtitle: Text(lstNotes[index].description.toString()),
                        trailing:
                            // IconButton(icon: Icon(Icons.delete),
                            //  onPressed: (){

                            //  },
                            // )
                            GestureDetector(
                          onTap: () {},
                          child: Icon(Icons.delete),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  saveNote() {}

  updateNote() {}
}
