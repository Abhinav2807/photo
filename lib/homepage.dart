

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui/flutter_firebase_ui.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:photo/dashboard.dart';
import 'package:toast/toast.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser user;

  HomePage({Key key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();
  String gender = null;
  bool male = false, female = false, others = false;
  DateTime dateofBirth;
  String bio;
  String name;
  Color color = Colors.orange;

  void _submit(BuildContext ctx) {
    if (formKey.currentState.validate() && gender != null) {
      formKey.currentState.save();
      print(gender);
      print(name);
      print(bio);
      print(dateofBirth);
      Navigator.of(ctx)
          .pushNamed(Dashboard.dashboardroute, arguments: [name, gender, bio]);
    } else {
      Toast.show("Fields are Missing", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bio",
          style: TextStyle(
              fontSize: 30, fontFamily: "Lobster", color: Colors.white60),
        ),
        backgroundColor: Colors.orangeAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              size: 30,
              color: Colors.white,
            ),
            // textColor: Colors.white60,
            onPressed: signOutProviders,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.5),
              color,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: MediaQuery.of(context).size.height * 0.20,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.user.photoUrl),
                      ),
                      borderRadius: BorderRadius.circular(80),
                      // boxShadow:
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    height: MediaQuery.of(context).size.height * .58,
                    width: 400,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      color: Colors.yellow[100],
                      elevation: 2,
                      child: Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: ListView(
                            children: <Widget>[
                              TextFormField(
                                cursorColor: Colors.orange,
                                initialValue: widget.user.displayName,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Enter Your Name",
                                  labelText: "Name",
                                ),
                                validator: (input) => !(input.length > 4)
                                    ? "Not valid name"
                                    : null,
                                onSaved: (input) => name = input,
                                onEditingComplete: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text("Male"),
                                      Checkbox(
                                        checkColor: Colors.orange,
                                        value: male,
                                        onChanged: (bool value) {
                                          setState(() {
                                            male = value;
                                            female = false;
                                            others = false;
                                            gender = value ? "Male" : null;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text("Female"),
                                      Checkbox(
                                        checkColor: Colors.orange,
                                        value: female,
                                        onChanged: (bool value) {
                                          setState(() {
                                            female = value;
                                            male = false;
                                            others = false;
                                            gender = value ? "Female" : null;
                                            print(gender);
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text("Others"),
                                      Checkbox(
                                        checkColor: Colors.orange,
                                        value: others,
                                        onChanged: (bool value) {
                                          setState(() {
                                            others = value;
                                            female = false;
                                            male = false;
                                            gender = value ? "Others" : null;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                child: FormBuilderDateTimePicker(
                                  inputType: InputType.date,
                                  initialValue: DateTime.now(),
                                  attribute: 'Date of Birth',
                                  decoration: InputDecoration(
                                    alignLabelWithHint: false,
                                    labelText: 'Date of Birth',
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              TextFormField(
                                cursorColor: Colors.orange,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: "Tell us about yourself",
                                    labelText: "Bio"),
                                // maxLines: 2,
                                validator: (input) => !(input.length > 10)
                                    ? "Bio is very short"
                                    : null,
                                onSaved: (input) => bio = input,
                                onEditingComplete: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  _submit(context);
                                },
                                child: Icon(Icons.arrow_forward),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
