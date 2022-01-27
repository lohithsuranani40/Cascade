import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:projectapp1/languages/hindipage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'CircleProgress.dart';
import 'languages/hindipage.dart';
class Dashboard1 extends StatefulWidget {
  @override
  _Dashboard1State createState() => _Dashboard1State();
}

class _Dashboard1State extends State<Dashboard1>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;
  //final GoogleSignIn googleSignIn = GoogleSignIn();

  final databaseReference = FirebaseDatabase.instance.reference();

  late AnimationController progressController;
  late Animation<double> tempAnimation;
  late Animation<int> humidityAnimation;
  late Animation<int> moistAnimation;



  @override
  void initState() {
    super.initState();

    databaseReference
        .child('ESP32_Device')
        .once()
        .then((DataSnapshot snapshot) {


      var temp = snapshot.value['Temperature']['Data'];

      double x=double.parse(temp.toStringAsFixed(2));
      print(num.parse(x.toStringAsFixed(2)));

      int humidity = snapshot.value['Humidity']['Data'];
      print(humidity);

      int moist = snapshot.value['Moisture']['Data'];
      print(humidity);


      isLoading = true;
      _Dashboard1Init(x, humidity,moist);
    });
  }

  _Dashboard1Init(double temp, int humid,int moist) {
    progressController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000)); //5s

    tempAnimation =
    Tween<double>(begin: 0, end: temp).animate(progressController)
      ..addListener(() {
        setState(() {});
      });

    humidityAnimation =
    IntTween(begin: 0, end: humid).animate(progressController)
      ..addListener(() {
        setState(() {});
      });
    moistAnimation =
    IntTween(begin: 0, end: moist).animate(progressController)
      ..addListener(() {
        setState(() {});
      });

    progressController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('निगरानी'),
        centerTitle: true,
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        leading: new IconButton(
            icon: Icon(Icons.reorder), onPressed: handleLoginOutPopup),
      ),
      body: Center(

          child: isLoading
              ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CustomPaint(
                foregroundPainter:
                CircleProgress(tempAnimation.value.toInt(), true,true),
                child: Container(
                  width: 200,
                  height: 200,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('तापमान'),
                        Text(
                          '${tempAnimation.value.toInt()}',
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '°C',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CustomPaint(
                foregroundPainter:
                CircleProgress(moistAnimation.value.toInt(), false,false),
                child: Container(
                  width: 200,
                  height: 200,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('मिट्टी की नमी'),
                        Text(
                          '${moistAnimation.value.toInt()}',
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '%',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CustomPaint(
                foregroundPainter:
                CircleProgress(humidityAnimation.value, false,true),
                child: Container(
                  width: 200,
                  height: 200,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('आसपास की नमी'),
                        Text(
                          '${humidityAnimation.value.toInt()}',
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '%',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(onPressed:(){
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return Dashboard1();
                }));
              }
                , child: Text('Refresh'),
                style: ElevatedButton.styleFrom(
                  primary : Colors.black,
                ),),
            ],
          )
              : Text(
            'कृपया प्रतीक्षा करें...',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )),
    );
  }

  handleLoginOutPopup() {
    Alert(
      context: context,
      type: AlertType.info,
      title: "Login Out",
      desc: "Do you want to login out now?",
      buttons: [
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.teal,
        ),
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: handleSignOut,
          color: Colors.teal,
        )
      ],
    ).show();
  }

  Future<Null> handleSignOut() async {
    this.setState(() {
      isLoading = true;
    });

    await FirebaseAuth.instance.signOut();
    //await googleSignIn.signOut();

    this.setState(() {
      isLoading = false;
    });

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => hindipage()),
            (Route<dynamic> route) => false);
  }
}