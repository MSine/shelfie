import 'package:flutter/material.dart';
import '../models/genre_model.dart';
import '../models/group_model.dart';

class GroupCreateScreen extends StatefulWidget {

  @override
  _GroupCreateScreenState createState() => _GroupCreateScreenState();
}

class _GroupCreateScreenState extends State<GroupCreateScreen> {
  String _groupName = '';
  String _groupDescription = '';
  late Future<List<Genre>> _genres;
  List<int> _acceptedGenres = [];

  @override
  void initState() {
    super.initState();
    _genres = Genre.fetchGenres();
  }

  void _selectGenres(List<Genre> genres) {
    final List<int> _newAcceptedGenres = List.from(_acceptedGenres);
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Select Genres"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: genres.map((genre) =>
                    CheckboxListTile(
                      title: Text(genre.name),
                      value: _newAcceptedGenres.contains(genre.id),
                      controlAffinity: ListTileControlAffinity.leading,
                      dense: true,
                      onChanged: (bool? newValue) {
                        setState(() {
                          if (newValue != null) {
                            if (newValue) {
                              _newAcceptedGenres.add(genre.id);
                            }
                            else {
                              _newAcceptedGenres.remove(genre.id);
                            }
                          }
                        });
                      },
                    ),
                  ).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () => {
                    Navigator.pop(context),
                    _acceptedGenres = _newAcceptedGenres,
                  },
                  child: Text("Ok"),
                ),
              ],
            );
          }
        );
      },
    ).then((val){
      setState(() {
        _acceptedGenres.sort();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Create A Group")
      ),
      floatingActionButton: ElevatedButton(
        child: Text("Create"),
        onPressed: () {
          Group.postCreateGroup(_groupName, _groupDescription, _acceptedGenres);
          Navigator.pop(context);
        },
      ),
      body: FutureBuilder<List<Genre>>(
        future: _genres,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return Center(child: Text("Book details not available"));
          }

          final genres = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and Descriptions
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Text(
                        'Enter Groups Name:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold
                        ),
                      ),
                      TextField(
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: "Name",
                        ),
                        onChanged: (value) {
                          _groupName = value;
                        },
                      ),
                      SizedBox(height: 32),
                      // Description
                      Text(
                        'Enter description of this group:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold
                        ),
                      ),
                      TextField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Description\nOf\nYour\nGroup",
                        ),
                        onChanged: (value) {
                          _groupDescription = value;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                // Genres
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Genres:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _selectGenres(genres),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _acceptedGenres.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(genres.firstWhere((g) => g.id == _acceptedGenres[index]).name),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
