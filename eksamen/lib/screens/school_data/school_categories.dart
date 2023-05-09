import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Elev extends StatelessWidget {
  const Elev({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance.collection('Elev').get(),
          builder: (context, snapshot) {
            if (snapshot.hasError){
              return Text('Error: ${snapshot.error}');
            }

            if (!snapshot.hasData){
              return CircularProgressIndicator();
            }
            

            List<Widget> elevList = [];

            snapshot.data!.docs.forEach((element) { 
              String navn = element['navn'];
              String adress = element['adresse'];
              String telefon = element['telefon'];
              String brukernavn = element['brukernavn'];
              String dataID = element['dataID'];
              //DateTime dataAlder = element['DataAlder'].toDate;
              String dataModel = element['dataModell'];
              print(element.data());
              print('object');

              elevList.add(ListTile(
                title: Text(navn),
                subtitle: Text(telefon),
                onTap: (){

                },
                ));

            });
            return ListView(children: elevList,);
          },
        ),
      ),
    );
  }
}