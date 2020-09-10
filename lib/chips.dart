import 'package:flutter/material.dart';

class chips extends StatefulWidget{
  final String title= 'User Chips';


  @override
  State<StatefulWidget> createState()=>_chipsState();

}

class _chipsState extends State<chips>{

  GlobalKey<ScaffoldState> _key;
  List<String> _dynamicChips;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _key= GlobalKey<ScaffoldState>();
    _dynamicChips=['Health','Health','reetesh'];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key:_key,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:Column(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: rowChips(),
          ),
          wraprowChips(),
          dynamicChips(),
        ],
      ),
    );
  }

  rowChips(){
    return Row(
      children: <Widget>[
        chipForRow('Heallth', Color(0xFFff8a65)),
        chipForRow('Heallth', Color(0xFFff8a65)),
        chipForRow('Heallth', Color(0xFFff8a65)),
        chipForRow('Heallth', Color(0xFFff8a65)),
      ],
    );
  }

  wraprowChips(){
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: <Widget>[
        chip('Heallth', Color(0xFFff8a65)),
        chip('Heallth', Color(0xFFff8a65)),
        chip('Heallth', Color(0xFFff8a65)),
        chip('Heallth', Color(0xFFff8a65)),
      ],
    );
  }

  dynamicChips(){
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: List<Widget>.generate(_dynamicChips.length, (int index){
        return Chip(
          label: Text(_dynamicChips[index]),
        );
      }),

    );
  }


  Widget chipForRow(String label, Color color){
    return Container(
      margin: EdgeInsets.all(5.0),
      child:Chip(
        labelPadding: EdgeInsets.all(5.0),
        avatar: CircleAvatar(
          backgroundColor: Colors.grey.shade600,
          child: Text(label[0].toUpperCase()),
        ),
        label:Text(
          label,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: color,
        elevation: 6.0,
        shadowColor: Colors.grey[60],
        padding: EdgeInsets.all(6.0),
      ),
    );
  }

  Widget chip(String label, Color color){
    return Chip(
        labelPadding: EdgeInsets.all(5.0),
        avatar: CircleAvatar(
          backgroundColor: Colors.grey.shade600,
          child: Text(label[0].toUpperCase()),
        ),
        label:Text(
          label,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: color,
        elevation: 6.0,
        shadowColor: Colors.grey[60],
        padding: EdgeInsets.all(6.0),
      );
  }

}