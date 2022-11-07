import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController rollNoCntrlr = TextEditingController();
  TextEditingController nameCntrlr = TextEditingController();
  Box? studentBox;
  @override
  void initState() {
    super.initState();

    studentBox = Hive.box("students");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive database'),
      ),
      body: Container(
        width: double.infinity,
        color: Colors.blueGrey,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return Dialog(
                          child: Column(
                            children: [
                              TextField(
                                controller: rollNoCntrlr,
                                decoration: InputDecoration(
                                  hintText: 'Roll Number',
                                ),
                              ),
                              TextField(
                                controller: nameCntrlr,
                                decoration: InputDecoration(
                                  hintText: 'Name',
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  studentBox?.put(
                                      //?writing data to hive student box object
                                      rollNoCntrlr.text,
                                      nameCntrlr.text);
                                  rollNoCntrlr.clear();
                                  nameCntrlr.clear();
                                  Navigator.pop(context);
                                },
                                child: Text('Submit'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Text("Add Student"),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return Dialog(
                          child: Column(
                            children: [
                              TextField(
                                controller: rollNoCntrlr,
                                decoration: InputDecoration(
                                  hintText: 'Roll Number',
                                ),
                              ),
                              TextField(
                                controller: nameCntrlr,
                                decoration: InputDecoration(
                                  hintText: 'Name',
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  studentBox?.put(
                                      //? same as add jus update at key
                                      //?writing data to hive student box object
                                      rollNoCntrlr.text,
                                      nameCntrlr.text);
                                  rollNoCntrlr.clear();
                                  nameCntrlr.clear();
                                  Navigator.pop(context);
                                },
                                child: Text('Submit'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Text("update Student"),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return Dialog(
                          child: Column(
                            children: [
                              TextField(
                                controller: rollNoCntrlr,
                                decoration: InputDecoration(
                                  hintText: 'Roll number',
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  studentBox?.delete(
                                      rollNoCntrlr.text); //! Delete the key
                                  rollNoCntrlr.clear();
                                  Navigator.pop(context);
                                },
                                child: Text('Submit'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Text("Delete Student"),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return Dialog(
                          child: Column(
                            children: [
                              TextField(
                                controller: rollNoCntrlr,
                                decoration: InputDecoration(
                                  hintText: 'Roll number',
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  print(
                                    studentBox?.get(
                                      //?reading data from the object
                                      rollNoCntrlr.text,
                                    ),
                                  );
                                  rollNoCntrlr.clear();
                                  Navigator.pop(context);
                                },
                                child: Text('Submit'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Text("Read Student"),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ValueListenableBuilder(
                //! is used to listen continuous changes
                valueListenable: studentBox!.listenable(),
                builder: (context, studentBox, child) {
                  return ListView.builder(
                    itemCount: studentBox.keys.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          studentBox.keyAt(index),
                        ),
                        subtitle: Text(
                          studentBox.getAt(index),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
