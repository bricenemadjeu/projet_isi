import 'package:flutter/material.dart';
import 'package:projet_isi/constants.dart';
import 'package:projet_isi/entite/formation.dart';
import '../api_manager.dart';
import 'menu.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';


class MainPage extends StatefulWidget{
  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage>{
  int _currentIndex = 0;
  final tabs = [

    Container(
        child: Column(
          children: <Widget>[
            Center(child: Text('Mes formations', style: TextStyle(fontSize: 25.0, color: Colors.white))),
            Container(
              margin: EdgeInsets.only(top: 20.0,left: 20.0),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.teal,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.badge, color: Colors.white,),
                        Text('2 Formation(s)', style: TextStyle(color: Colors.white),),
                        Text('Encours', style: TextStyle(color: Colors.white70),),
                      ],
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.topEnd,
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.only(left: 5.0),
                    color: Colors.teal,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.emoji_people, color: Colors.white,),
                        Text('1 Formation(s)', style: TextStyle(color: Colors.white),),
                        Text('Terminée', style: TextStyle(color: Colors.white70),),
                      ],
                    ),
                  ),
                  IconButton(
                      iconSize: 40.0,
                      icon: Icon(Icons.refresh),
                      onPressed: (){
                          fetchFormation();
                      })
                ],

              ),
            ),
            FutureBuilder(
                future: fetchFormation(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Expanded(
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          shrinkWrap: true,
                          itemBuilder:(BuildContext context, index){
                            Formation formation = snapshot.data[index];
                            return Card(
                              elevation: 10.0,
                              margin: EdgeInsets.only(top: 20.0,left: 20.0, right: 20.0),
                              color: mainColor,
                              child: Container(
                                margin: EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.badge, color: Colors.white),
                                        Text(' ${formation.formationName}'.toUpperCase(),style: TextStyle(color: Colors.white))
                                      ],
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
                                      child: Text('Spécialité: ${formation.formationSpecialite}',style: TextStyle(color: Colors.white)),
                                    ),
                                    Text('${formation.description}',style: TextStyle(color: Colors.white)),
                                    Container(
                                        alignment: Alignment.bottomLeft,
                                        margin: EdgeInsets.only(left: 0.0,bottom: 10.0),
                                        child: Text("Du "+formation.startDate.day.toString()+"-"+formation.startDate.month.toString()+"-"+formation.startDate.year.toString()+" au "+formation.endDate.day.toString()+"-"+formation.endDate.month.toString()+"-"+formation.endDate.year.toString(),style: TextStyle(fontSize: 15.0, color: Colors.white))
                                    ),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      child: RaisedButton(
                                        elevation: 5.0,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30.0),
                                        ),
                                        onPressed: () {

                                        },
                                        child: Text(
                                          "Choisir >",
                                          style: TextStyle(
                                            color: mainColor,
                                            letterSpacing: 1.5,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),

          ],
        ),
      ),
    Center(child: Text('Formations ISJ')),
    Center(child: Text('Paramètres'))
  ];


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Apply to ISJ - Formations'),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 30.0,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.badge),
            title: Text('Mes formations'),
            backgroundColor: mainColor
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('Formations ISJ'),
              backgroundColor: mainColor
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Profile'),
              backgroundColor: mainColor
          ),
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      drawer: Drawer(
        child: MenuUser(),
      ),
    );
  }



}