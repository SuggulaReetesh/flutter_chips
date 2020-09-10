import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

class UserSearch extends StatefulWidget {
  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  List<AppProfile> suggestions = [];
  List<AppProfile> finalList = [];
  TextEditingController controller = new TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    const mockResults = <AppProfile>[
      AppProfile('John Doe', 'jdoe@flutter.io',
          'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX4057996.jpg'),
      AppProfile('Paul', 'paul@google.com',
          'https://mbtskoudsalg.com/images/person-stock-image-png.png'),
      AppProfile(
          'Freddddddddddddddddddddddddddddddddddddddddd',
          'fred@google.com',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      AppProfile('Brian', 'brian@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      AppProfile('John', 'john@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      AppProfile('Thomas', 'thomas@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      AppProfile('Nelly', 'nelly@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      AppProfile('Marie', 'marie@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      AppProfile('Charlie', 'charlie@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      AppProfile('Diana', 'diana@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      AppProfile('Ernie', 'ernie@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
      AppProfile('Gina', 'fred@flutter.io',
          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
    ];

    void addSuggestion(AppProfile p) {
      bool profileExists = false;
      setState(() {
        for (int i = 0; i < finalList.length; i++) {
          if (finalList[i].email == p.email) {
            profileExists = true;
            break;
          }
        }
        if (!profileExists) suggestions.add(p);
      });
    }

    void clearSuggestions() {
      setState(() {
        suggestions.clear();
      });
    }

    void addToFinalList(AppProfile p, int index) {
      bool profileExists = false;

      setState(() {
        for (int i = 0; i < finalList.length; i++) {
          if (finalList[i].email == p.email) {
            profileExists = true;
            break;
          }
        }
        if (!profileExists) {
          finalList.add(p);
        }
        suggestions.removeAt(index);
      });
    }

    void deleteFromFinalList(int index) {
      setState(() {
        finalList.removeAt(index);
        controller.clear();
        suggestions.clear();
      });
    }

    Widget successor() {
      return Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Chip(
          label: Text(
            "Successor",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'ProductSans',
            ),
          ),
          backgroundColor: Colors.indigo[800],
          avatar: Icon(
            Icons.beach_access,
            color: Colors.white,
          ),
        ),
      );
    }

    Widget mainChip(String name, String url, int index) {
      if (name.length > 15) {
        name = name.substring(0, 15) + "...";
      }
      return Padding(
        padding: EdgeInsets.only(right: 5),
        child: Chip(
          label: Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'ProductSans',
            ),
          ),
          backgroundColor: Colors.indigo[800],
          // deleteIcon: Icon(
          //   Icons.cancel,
          //   color: Colors.white,
          //   size: 18,
          // ),
          // onDeleted: () => {deleteFromFinalList(index)},
          avatar: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(url),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Wrap(
                children: [
                  successor(),
                  for (int i = 0; i < finalList.length; i++)
                    mainChip(finalList[i].name, finalList[i].imageUrl, i)
                ],
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: controller,
                decoration: InputDecoration(hintText: 'Search'),
                onChanged: (value) => {
                  clearSuggestions(),
                  if (value.length > 0)
                    {
                      for (int i = 0; i < mockResults.length; i++)
                        {
                          if (mockResults[i]
                              .name
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                            {addSuggestion(mockResults[i])}
                        }
                    }
                  else
                    {clearSuggestions()}
                },
              ),
              Container(
                height: suggestions.length * 100.0,
                child: Column(
                  children: [
                    for (int i = 0; i < suggestions.length; i++)
                      ListTile(
                        onTap: () => {addToFinalList(suggestions[i], i)},
                        title: Text(suggestions[i].name),
                      )
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Center(
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  color: Colors.indigo[800],
                  onPressed: () => {print(finalList)},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "Save",
                      style: TextStyle(
                          fontFamily: 'ProductSans',
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppProfile {
  final String name;
  final String email;
  final String imageUrl;

  const AppProfile(this.name, this.email, this.imageUrl);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppProfile &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return name;
  }
}

class Successor {
  final String name;

  const Successor(this.name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppProfile &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return name;
  }
}
