import 'package:flutter/material.dart';

import 'package:insert_update_delete/update_delete.dart';

class Insert extends StatefulWidget {
  const Insert({Key? key}) : super(key: key);

  @override
  State<Insert> createState() => _InsertState();
}

class _InsertState extends State<Insert> {


  TextEditingController txt_name = TextEditingController();
  TextEditingController txt_phonenumber = TextEditingController();
  TextEditingController txt_Email = TextEditingController();

  List<InsertModel> myproduct = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text("Contact App ",
              style: TextStyle(fontSize: 19, color: Colors.white)),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Enter your contacts"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: txt_name,
                                      decoration: InputDecoration(
                                          hintText: 'Enter your name'),
                                    ),
                                    TextField(
                                      controller: txt_phonenumber,
                                      decoration: InputDecoration(
                                          hintText: 'Enter your phone number'),
                                    ),
                                    TextField(
                                      controller: txt_Email,
                                      decoration: InputDecoration(
                                          hintText: 'Enter Email Id'),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("CANCEL")),
                                  TextButton(
                                    onPressed: () {
                                      String pname = txt_name.text;
                                      String pnumber = txt_phonenumber.text;
                                      String Email = txt_Email.text;

                                      InsertModel insertModel = InsertModel(
                                          name: pname,
                                          number: pnumber,
                                          Email: Email);

                                      setState(
                                        () {
                                          myproduct.add(insertModel);
                                        },
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("ADD"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 20.0),
                          primary: Colors.black,
                        ),
                        child: Text(
                          " Add Phone Number ",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: myproduct.length,
                itemBuilder: (context, index) {
                  return MyProduct(index, myproduct[index].name!,
                      myproduct[index].number!, myproduct[index].Email!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget MyProduct(int Index, String? name, String? number, String? id) {
    return ListTile(
      leading: Text(
        "$Index",
        style: TextStyle(fontSize: 18),
      ),
      title: Text("$name"),
      subtitle: Text("$number"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("$id"),
          IconButton(
            onPressed: () {
              txt_name = TextEditingController(text: "$name");
              txt_phonenumber = TextEditingController(text: "$number");
              txt_Email = TextEditingController(text: "$id");
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Enter Product Detail'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          controller: txt_name,
                          decoration: const InputDecoration(
                            hintText: 'Enter  name',
                          ),
                        ),
                        TextField(
                          controller: txt_phonenumber,
                          decoration: const InputDecoration(
                            hintText: 'Enter number ',
                          ),
                        ),
                        TextField(
                          controller: txt_Email,
                          decoration: const InputDecoration(
                            hintText: 'Enter Email ',
                          ),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('CANCEL'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('UPDATE'),
                        onPressed: () {
                          setState(() {
                            InsertModel p1 = InsertModel(
                              name: txt_name.text,
                              number: txt_phonenumber.text,
                              Email: txt_Email.text,
                            );
                            myproduct[Index] = p1;
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(
              Icons.edit,
              color: Colors.deepPurpleAccent,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(
                () {
                  myproduct.removeAt(Index);
                },
              );
            },
            icon: Icon(
              Icons.delete,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
