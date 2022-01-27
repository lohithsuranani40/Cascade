import 'package:projectapp1/Userfile.dart';
import 'package:projectapp1/ricefile.dart';
import 'package:projectapp1/Dashboard.dart';
import 'package:projectapp1/languages/govten.dart';
import 'package:projectapp1/weather/weatheren.dart';
import 'package:flutter/material.dart';
import 'package:projectapp1/ml models/recomendation.dart';




class englishpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
        title: 'Cascade',
        key: null,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    required key,
    required this.title,
    centerTitle: true,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Agri> data = <Agri>[
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(widget.title),
        actions: <Widget>[
          Container(
            color: Colors.lightGreen,
            child: Padding(
                padding: EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>UserPage()),
                    );
                  },
                  child: SizedBox(
                    height: 10,
                    width: 100,
                    child: Container(
                      child: Text(
                        "User Input",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      //decoration: BoxDecoration(
                      //color: Colors.yellow,
                      //borderRadius: BorderRadius.circular(20),
                      //),
                    ),
                  ),
                )),
          ),
        ],
      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network('https://images.unsplash.com/photo-1599619800607-e56e461c13d6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1651&q=80',
          )
          ,SizedBox(height:10,),

          ElevatedButton(

            onPressed: (){
              Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context) => new Dashboard()));
              //   Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Graphpage()),
              // );
            },
            child: Text('Live Monitoring'),
            style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) =>
                  MyExpandableWidget(data[index]),
              itemCount: data.length,
            ),
          ),
          ElevatedButton(

            onPressed: (){
              Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context) => new govten()));

            },
            child: Text('Government Schemes'),
            style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) =>
                  MyExpandableWidget(data[index]),
              itemCount: data.length,
            ),
          ),
          ElevatedButton(

            onPressed: (){
              Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context) => new weatheren()));
              //   Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Graphpage()),
              // );
            },
            child: Text('Weather Updates'),
            style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) =>
                  MyExpandableWidget(data[index]),
              itemCount: data.length,
            ),
          ),
          ElevatedButton(

            onPressed: (){
              Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context) => new recomendation()));

            },
            child: Text('Crop recomendtaion'),
            style: ElevatedButton.styleFrom(
                primary: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) =>
                  MyExpandableWidget(data[index]),
              itemCount: data.length,
            ),
          ),
        ],
      ),
    );
  }
}

class MyExpandableWidget extends StatelessWidget {
  final Agri agri;

  MyExpandableWidget(this.agri);

  @override
  Widget build(BuildContext context) {
    if (agri.listGroups.isEmpty)
      return ListTile(
        title: Text(agri.agriName),
      );
    return ExpansionTile(
      key: PageStorageKey<Agri>(agri),
      title: Text(agri.agriName,
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.purple)),
      children: agri.listGroups
          .map<Widget>((group) => showGroups(group, context))
          .toList(),
    );
  }
}

showGroups(Group group, BuildContext context) {
  return new ExpansionTile(
    key: PageStorageKey<Group>(group),
    title: Text(
      group.groupName,
      style: TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
    ),
    children: group.listBatches
        .map<Widget>((batch) => showBatches(batch, context))
        .toList(),
  );
}

showBatches(Batch batch, BuildContext context) {
  return new ListTile(
    onTap: () {

      if (batch.batchName == "Maize") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RicePage(batch.batchName)),
        );
      }

    },
    title: new Text(
      batch.batchName,
      style: new TextStyle(fontSize: 20),
    ),
  );
}

class Agri {
  String agriName;
  List<Group> listGroups;

  Agri(this.agriName, this.listGroups);
}

class Group {
  String groupName;
  List<Batch> listBatches;

  Group(this.groupName, this.listBatches);
}

class Batch {
  String batchName;

  Batch(this.batchName);
}



