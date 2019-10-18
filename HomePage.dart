import 'package:flutter/material.dart';  

import 'package:cloud_firestore/cloud_firestore.dart'; //impor cloud fire store nya
import 'dart:async'; //imprt lagi

class Home extends StatefulWidget { //ketik st aja pilih yg StatefulWidget, lalu beri nam dengan "Home"
  @override                                      //lalu masukan Home nya di main.dart
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

              //koding ini koneksi dtabase firestore
            StreamSubscription<QuerySnapshot>subscription;
            List<DocumentSnapshot>snapshot;
            CollectionReference collectionReference=Firestore.instance.collection("TopPost");
              
              //for body post
              StreamSubscription<QuerySnapshot>sdSubscription;
              List<DocumentSnapshot>sdSnapshot;
              CollectionReference sdcollectionReference=Firestore.instance.collection("BodyPost");
              @override
            void initState() {
              subscription=collectionReference.snapshots().listen((datasnapshot){
                    setState(() {
                      snapshot=datasnapshot.documents;
                    });
              });
              // TODO: implement initState
                     //sdsubcripstion
              sdSubscription=sdcollectionReference.snapshots().listen((sddatasnap)
              {
                sdSnapshot=sddatasnap.documents;
              }
              );
              super.initState();
            }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(  // lalu container ganti jadi Scaffold widget

      appBar: new AppBar(  // lalu buat appBar
        title: new Text("Manin Flutter"),
        backgroundColor: Colors.purple,

         actions: <Widget>[ //action widget,,buat icon button
             
             new IconButton(  //icon button cari
               icon: new Icon(Icons.search),
               onPressed: ()=> debugPrint("search")
             ),

             new IconButton( //icon button tambah
               icon: new Icon(Icons.add),
               onPressed: ()=> debugPrint("Add")
             )

         ],
      ),
      


      drawer: new Drawer(   //lalu buat menu drawer pojok kiri atas
        child: new ListView(
           children: <Widget>[  //lalu buat children <widget> nya
             new UserAccountsDrawerHeader(  // buat user account
                   accountName: new Text("Manin"),
                   accountEmail: new Text("manin45678@gmail.com"),
                   decoration: new BoxDecoration( //ganti background color user account
                        color: Colors.purple
                   ),
             ),


             new ListTile(// buat list di dalam widget
               title: new Text("Halaman Pertama"), //judulnya
               trailing: new Icon(Icons.search,color: Colors.green,), //buat icon nya
             ), //jika ingin buat list dibawanya lgi, gunakan koma dsni lalu buat lagi, yg yg terakhir tanpa koma

             new ListTile( // list kedua
               title: new Text("Halaman Kedua"),
               trailing: new Icon(Icons.add,color: Colors.purple,),
             ),

             new ListTile( //list ketiga
               title: new Text("Halaman Ketiga"),
               trailing: new Icon(Icons.cake,color: Colors.redAccent),
             ),

             new Divider( // buat garis hitam divider namanya
               height: 10.0,
               color: Colors.black,
             ),


             new ListTile(// list ke empat, buat close
               trailing: new Text("Close"),
               leading: new Icon(Icons.close,color:Colors.red),
                  onTap: (){ // ini aksi agar list close di klik akan,,keluar / kembali
                    Navigator.of(context).pop(); //pakai navigator pop
                  },
             )
           ],
          
        ),
      ),

     body: new ListView( //koding setelah koneksiin database
       children: <Widget>[
           new Container(
             height: 200,
             child: new ListView.builder(
               itemCount: snapshot.length,
               scrollDirection: Axis.horizontal,
               itemBuilder: (context,index){
                 return Card(
                      elevation: 10.0,
                      margin: EdgeInsets.all(10.0),
                      child:new Container(
                         margin: EdgeInsets.all(10.0),

                          child: new Column(
                        children: <Widget>[
                          new ClipRRect(
                          borderRadius: new BorderRadius.circular(10.0),
                           child: new Image.network(snapshot[index].data["url"],
                           height:120.0,
                           width: 120.0,
                           fit: BoxFit.cover,
                           ),
                          ),

                          new SizedBox(height: 10.0,),
                          new Text(snapshot[index].data["title"],
                          style: TextStyle(fontSize: 19.0,color: Colors.purple),
                          )
                        ],
                      ),

                      )
                    
                 );
               }
                ),
           ),
           //end first container

           new Container(
             height: MediaQuery.of(context).size.height,
            child: new ListView.builder(
              itemCount: snapshot.length,
              itemBuilder: (context,index){
                return Card(
                  elevation: 7.0,
                  margin: EdgeInsets.all(10.0),
                    child: new Container(
                      padding: EdgeInsets.all(10.0),
                       child: new Column(
                         children: <Widget>[

                           new Row(
                             children: <Widget>[
                               new CircleAvatar(
                                 child: new Text(sdSnapshot[index].data["title"][0],
                                 
                                 ),
                                 backgroundColor: Colors.purple,
                                 foregroundColor: Colors.white,


                               ),
                               new SizedBox(width: 10.0,),
                               new Text(sdSnapshot[index].data["title"],
                               style: TextStyle(fontSize: 20.0,color: Colors.purple),
                               )
                               
                             ],
                           ),
                            
                            new SizedBox(height: 10.0,),
                            new Column(
                              children: <Widget>[
                                new ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: new Image.network(sdSnapshot[index].data["url"],
                                   // height: 150.0,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                  ),
                                ),

                              ],
                            )

                         ],
                       ),
                    ),
                );
              },
            ),
           )
       ],
     ), 
      
    );
  }
}