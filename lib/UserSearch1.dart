import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

class UserSearch1 extends StatefulWidget {
  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch1> {
  GlobalKey<ChipsInputState> _chipKey = GlobalKey();
  var finalList;
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ChipsInput(
                initialValue: [],
                key: _chipKey,
                enabled: true,
                textStyle: TextStyle(
                    height: 1.5, fontFamily: "ProductSans", fontSize: 16),
                decoration: InputDecoration(
                  labelText: "Select People",
                  enabled: true,
                ),
                findSuggestions: (String query) {
                  if (query.length > 0) {
                    var lowercaseQuery = query.toLowerCase();
                    return mockResults.where((profile) {
                      return profile.name
                              .toLowerCase()
                              .contains(query.toLowerCase()) ||
                          profile.email
                              .toLowerCase()
                              .contains(query.toLowerCase());
                    }).toList(growable: false)
                      ..sort((a, b) => a.name
                          .toLowerCase()
                          .indexOf(lowercaseQuery)
                          .compareTo(
                              b.name.toLowerCase().indexOf(lowercaseQuery)));
                  } else {
                    return mockResults;
                  }
                },
                autofocus: true,
                onChanged: (data) {
                  setState(() {
                    finalList = data;
                  });
                },
                chipBuilder: (context, state, profile) {
                  return InputChip(
                    key: ObjectKey(profile),
                    label: profile.name.length > 15
                        ? Text(profile.name.substring(0, 15) + "...")
                        : Text(profile.name),
                    avatar: CircleAvatar(
                      backgroundImage: NetworkImage(profile.imageUrl),
                    ),
                    onDeleted: () => state.deleteChip(profile),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  );
                },
                suggestionBuilder: (context, state, profile) {
                  return ListTile(
                    key: ObjectKey(profile),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(profile.imageUrl),
                    ),
                    title: Text(profile.name),
                    subtitle: Text(profile.email),
                    onTap: () => {
                      state.selectSuggestion(profile),
                    },
                  );
                },
              ),
              SizedBox(
                height: 200,
              ),
              MaterialButton(
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
