import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path/path.dart';
import 'package:sqlite_example/utils/dbHelper.dart';

import '../model/notes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.personId});

  final int personId;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataBaseHelper dbHelper = DataBaseHelper();

  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtDetail = TextEditingController();
  List<Notes> lstNotes = <Notes>[];

  int selectedId = -1;

  @override
  void initState() {
    super.initState();
    setState(() {
      getNotes();
    });
  }

  void getNotes() async {
    List<Notes> noteFuture = await dbHelper.getAllNotes();
    setState(() {
      lstNotes = noteFuture;
    });
  }

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
                  onPressed: saveNote,
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
            lstNotes.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                        itemCount: lstNotes.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  txtTitle.text =
                                      lstNotes[index].title.toString();
                                  txtDetail.text =
                                      lstNotes[index].description.toString();
                                  selectedId = lstNotes[index].id!;
                                });
                              },
                              title: Text(lstNotes[index].title!),
                              subtitle:
                                  Text(lstNotes[index].description.toString()),
                              trailing:
                                  // IconButton(icon: Icon(Icons.delete),
                                  //  onPressed: (){

                                  //  },
                                  // )
                                  GestureDetector(
                                onTap: () {
                                  deleteNote(lstNotes[index].id!);
                                },
                                child: Icon(Icons.delete),
                              ),
                            ),
                          );
                        }),
                  )
                : Card(),
          ],
        ),
      ),
    );
  }

  saveNote() {
    if (txtTitle.text.isNotEmpty) {
      Notes note = Notes(
          txtTitle.text.toString(), txtDetail.text.toString(), widget.personId);
      dataSave(note);
    }
  }

  dataSave(Notes note) async {
    await dbHelper.insert(note);
    setState(() {
      getNotes();
      txtTitle.text = "";
      txtDetail.text = "";
    });
  }

  updateNote() {
    if (selectedId > 0) {
      update(Notes.withId(selectedId, txtTitle.text.toString(),
          txtDetail.text.toString(), widget.personId));
    }
  }

  Future<void> update(Notes note) async {
    await dbHelper.update(note);
    setState(() {
      getNotes();
      txtDetail.text = "";
      txtTitle.text = "";
      selectedId = -1;
    });
  }

  deleteNote(int id) {
    delete(id);
  }

  Future<void> delete(int id) async {
    await dbHelper.delete(id);
    setState(() {
      getNotes();
    });
  }
}
