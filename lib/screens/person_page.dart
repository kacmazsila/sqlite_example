import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqlite_example/screens/home_page.dart';
import 'package:sqlite_example/utils/dbHelper.dart';

import '../model/Person.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  List<Person> lstPerson = <Person>[];
  TextEditingController txtName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtTitle = TextEditingController();

  DataBaseHelper dbhelper = DataBaseHelper();

  int selectedId = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      getPeople();
    });
  }

  getPeople() async {
    var result = await dbhelper.getAllPerson();
    setState(() {
      lstPerson = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kişiler"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                controller: txtName,
                decoration: const InputDecoration(
                    label: Text('Ad'), border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                controller: txtLastName,
                decoration: const InputDecoration(
                    label: Text('Soyad'), border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                controller: txtTitle,
                decoration: const InputDecoration(
                    label: Text('Ünvan'), border: OutlineInputBorder()),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: savePerson,
                  child: const Text('Kaydet'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                ),
                ElevatedButton(
                  onPressed: updatePerson,
                  child: const Text('Güncelle'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                  ),
                )
              ],
            ),
            lstPerson.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                        itemCount: lstPerson.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage(
                                          personId: lstPerson[index].id!)),
                                );
                                // setState(() {
                                //   txtTitle.text =
                                //       lstPerson[index].title.toString();
                                //   txtName.text =
                                //       lstPerson[index].name.toString();
                                //   selectedId = lstPerson[index].id!;
                                //   txtLastName.text = lstPerson[index].lastname!;
                                // });
                              },
                              title: Text(lstPerson[index].title!),
                              subtitle: Text(
                                  "${lstPerson[index].name} ${lstPerson[index].lastname!}"),
                              trailing:
                                  // IconButton(icon: Icon(Icons.delete),
                                  //  onPressed: (){

                                  //  },
                                  // )
                                  GestureDetector(
                                onTap: () {
                                  deletePerson(lstPerson[index].id!);
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

  savePerson() {
    Person person = Person(txtName.text.toString(), txtLastName.text.toString(),
        txtTitle.text.toString());
    save(person);
  }

  Future<void> save(Person person) async {
    dbhelper.insertPerson(person);
    setState(() {
      getPeople();
    });
  }

  updatePerson() {
    Person person = Person.withId(selectedId, txtName.text.toString(),
        txtLastName.text.toString(), txtTitle.text.toString());

    update(person);
  }

  Future<void> update(Person person) async {
    dbhelper.updatePerson(person);
    setState(() {
      getPeople();
    });
  }

  deletePerson(int id) async {
    dbhelper.deletePerson(selectedId);
    setState(() {
      getPeople();
    });
  }
}
