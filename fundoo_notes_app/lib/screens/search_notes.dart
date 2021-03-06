import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'signup.dart';

class SearchNotes extends StatefulWidget {
  SearchNotesState createState() => SearchNotesState();
}

class SearchNotesState extends State<SearchNotes> {
  FocusNode myFocusNote = FocusNode();

  String searchString = '';

  TextEditingController _searchStringController = TextEditingController();

  var child;
  late String sharedPreferenceEmail;
  List allNotesData = [];
  List searchNotes = [];
  late Color _color = Colors.white;

  Future<void> getNotesData() async {
    final prefs = await SharedPreferences.getInstance();
    sharedPreferenceEmail = prefs.getString('email')!;

    Query collectionReference = FirebaseFirestore.instance
        .collection('notes')
        .where("trash", isEqualTo: false)
        .where("archived", isEqualTo: false)
        .where("email", isEqualTo: sharedPreferenceEmail);

    QuerySnapshot querySnapshot = await collectionReference.get();
    print('........');

    final notesAllData = querySnapshot.docs.map((data) => data.data()).toList();
    print(
        '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    print(notesAllData);
    //notesAllData.sort();
    querySnapshot.docs.forEach((notesAllData) {
      var map = {
        'email': notesAllData['email'],
        'firstName': notesAllData['firstName'],
        'color': notesAllData['color'],
        'note': notesAllData['note'],
        'title': notesAllData['title'],
        'pin': notesAllData['pin'],
        'archived': notesAllData['archived'],
        'id': notesAllData.id
      };
      setState(() {
        allNotesData.add(map);
      });
    });
  }

  searchNotesData(value) {
    setState(() {
      if (value != '') {
        searchNotes = allNotesData
            .where((allNotesData) =>
                allNotesData['title'].toString().toLowerCase().contains(value))
            .toList();
      } else {
        searchNotes = List.empty();
      }
      print('////////////////////////////////////////');
      print(searchNotes);
    });
  }

  @override
  void initState() {
    super.initState();
    getNotesData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white10,
        foregroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            icon: Icon(Icons.arrow_back)),
        title: TextField(
          autofocus: true,
          style: TextStyle(fontSize: 22),
          decoration: new InputDecoration(
            hintText: 'Search Notes',
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
          onChanged: (value) {
            searchNotesData(value);
          },
        ),
        bottom: PreferredSize(
            child: Container(
              color: Colors.black,
              height: 1.0,
            ),
            preferredSize: Size.fromHeight(1.0)),
      ),
      body: ListView.builder(
          itemCount: searchNotes.length,
          itemBuilder: (BuildContext context, int index) {
            _color = Colors.white;
            print('???????????????????????????????????????????');
            print(searchNotes[index]['color']);
            if (searchNotes[index]['color'] != "") {
              print('/////////////');
              String valueString = searchNotes[index]['color']
                  .toString()
                  .split('(0x')[1]
                  .split(')')[0];
              int value = int.parse(valueString, radix: 16);
              Color otherColor = new Color(value);
              _color = otherColor;
              print(_color);
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/updateNotes', arguments: {
                    'email': searchNotes[index]['email'],
                    'firstName': searchNotes[index]['firstName'],
                    'color': searchNotes[index]['color'],
                    'note': searchNotes[index]['note'],
                    'title': searchNotes[index]['title'],
                    'pin': searchNotes[index]['pin'],
                    'archived': searchNotes[index]['archived'],
                    'id': searchNotes[index]['id'],
                    'rootSource': 'searchNotes'
                  });
                },
                child: Card(
                    color: _color,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black12, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                        child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            searchNotes[index]['title'],
                            style: TextStyle(fontSize: 22),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            searchNotes[index]['note'],
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ))),
              ),
            );
          }),
      // ]),
    );
  }
}
