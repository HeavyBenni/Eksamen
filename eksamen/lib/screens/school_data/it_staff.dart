import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

late String globalNavn;
late String globalAdress;
late String globalTelefon;
late String globalBrukernavn;
late String globalDataId;
late String globalDataAlder;
late String globalDataModell;
late String globalDocId;

class ItStaff extends StatefulWidget {
  const ItStaff({Key? key});

  @override
  State<ItStaff> createState() => _ItStaffState();
}

class _ItStaffState extends State<ItStaff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('IT-medarbeidere'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Legg til'),
                  SizedBox(
                    width: 30,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ItStaffAdd(),
                            ),
                          );
                        },
                        child: Icon(Icons.add_circle_outline)),
                  )
                ],
              ),
              Center(
                child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance
                      .collection('IT-medarbeider')
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }

                    List<Widget> elevList = [];

                    snapshot.data!.docs.forEach(
                      (element) {
                        String navn = element['navn'];
                        String adress = element['adresse'];
                        String telefon = element['telefon'];
                        String brukernavn = element['brukernavn'];
                        String dataID = element['dataID'];
                        String dataAlder = element['dataAlder'];
                        String dataModell = element['dataModell'];
                        bool isLoading = false;

                        elevList.add(
                          Stack(
                            children: [
                              ListTile(
                                title: Text(navn),
                                subtitle: Text(telefon),
                                trailing: SizedBox(
                                  width: 40,
                                  child: TextButton(
                                      onPressed: () {
                                        try {
                                          setState(() {
                                            FirebaseFirestore.instance
                                                .collection('IT-medarbeider')
                                                .doc(element.id)
                                                .delete();
                                          });

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'IT-medarbeider slettet'),
                                            ),
                                          );
                                          //Navigator.of(context).pop();
                                        } catch (error) {
                                          print(
                                              'Error adding IT-medarbeidere: $error');
                                        }
                                      },
                                      child: Icon(Icons.remove_circle_outline)),
                                ),
                                onTap: () {
                                  globalNavn = navn;
                                  globalAdress = adress;
                                  globalTelefon = telefon;
                                  globalBrukernavn = brukernavn;
                                  globalDataId = dataID;
                                  globalDataAlder = dataAlder;
                                  globalDataModell = dataModell;
                                  globalDocId = element.id;
                                  setState(() {
                                    isLoading = true;
                                  });
                                  Navigator.of(context)
                                      .push(
                                    MaterialPageRoute(
                                      builder: (context) => const ItStaffEdit(),
                                    ),
                                  )
                                      .then(
                                    (value) {
                                      setState(
                                        () {
                                          isLoading = false;
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                              if (isLoading)
                                Positioned.fill(
                                  child: Container(
                                    color: Colors.black.withOpacity(0.5),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    );

                    return Column(
                      children: elevList,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItStaffAdd extends StatefulWidget {
  const ItStaffAdd({super.key});

  @override
  State<ItStaffAdd> createState() => _ItStaffAddState();
}

class _ItStaffAddState extends State<ItStaffAdd> {
  final _formKey = GlobalKey<FormState>();

  final _navnController = TextEditingController();
  final _adresseController = TextEditingController();
  final _telefonController = TextEditingController();
  final _brukernavnController = TextEditingController();
  final _dataIDController = TextEditingController();
  final _dataAlderController = TextEditingController();
  final _dataModellController = TextEditingController();

  Future<void> _saveData() async {
    final data = {
      'navn': _navnController.text,
      'adresse': _adresseController.text,
      'telefon': _telefonController.text,
      'brukernavn': _brukernavnController.text,
      'dataID': _dataIDController.text,
      'dataAlder': _dataAlderController.text,
      'dataModell': _dataModellController.text,
    };

    try {
      await FirebaseFirestore.instance.collection('IT-medarbeider').add(data);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data saved successfully'),
        ),
      );
      Navigator.of(context).pop();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save data: $error'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _navnController.dispose();
    _adresseController.dispose();
    _telefonController.dispose();
    _brukernavnController.dispose();
    _dataIDController.dispose();
    _dataAlderController.dispose();
    _dataModellController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Legg til IT-medarbeider'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 50,
                  child: TextFormField(
                    controller: _navnController,
                    decoration: const InputDecoration(
                      labelText: 'Navn',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.draw,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 50,
                  child: TextFormField(
                    controller: _adresseController,
                    decoration: const InputDecoration(
                      labelText: 'Adresse',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.draw,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 50,
                  child: TextFormField(
                    controller: _telefonController,
                    decoration: const InputDecoration(
                      labelText: 'Telefon',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.draw,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 50,
                  child: TextFormField(
                    controller: _brukernavnController,
                    decoration: const InputDecoration(
                      labelText: 'Brukernavn',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.draw,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 50,
                  child: TextFormField(
                    controller: _dataIDController,
                    decoration: const InputDecoration(
                      labelText: 'DataID',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.draw,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 50,
                  child: TextFormField(
                    controller: _dataAlderController,
                    decoration: const InputDecoration(
                      labelText: 'DataAlder',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.draw,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 50,
                  child: TextFormField(
                    controller: _dataModellController,
                    decoration: const InputDecoration(
                      labelText: 'DataModell',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.draw,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await FirebaseFirestore.instance
                              .collection('IT-medarbeider')
                              .add({
                            'navn': _navnController.text,
                            'adresse': _adresseController.text,
                            'telefon': _telefonController.text,
                            'brukernavn': _brukernavnController.text,
                            'dataID': _dataIDController.text,
                            'dataAlder': _dataAlderController.text,
                            'dataModell': _dataModellController.text,
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('IT-medarbeider lagt til'),
                            ),
                          );
                          Navigator.of(context).pop();
                        } catch (error) {
                          print('Error adding IT-medarbeider: $error');
                        }
                      }
                    },
                    child: const Text('Legg til'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItStaffEdit extends StatefulWidget {
  const ItStaffEdit({Key? key});

  @override
  State<ItStaffEdit> createState() => _ItStaffEditState();
}

class _ItStaffEditState extends State<ItStaffEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Oppdater Opplysninger'),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 50,
                    child: TextFormField(
                      initialValue: globalNavn,
                      decoration: const InputDecoration(
                        labelText: 'Navn',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.draw,
                        ),
                      ),
                      onEditingComplete: () {
                        FirebaseFirestore.instance
                            .collection('IT-medarbeider')
                            .doc(globalDocId)
                            .update({'navn': globalNavn})
                            .then((value) => print('Document updated'))
                            .catchError((error) =>
                                print('Failed to update document: $error'));
                        FocusScope.of(context).unfocus();
                      },
                      onChanged: (value) {
                        setState(() {
                          globalNavn = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 50,
                    child: TextFormField(
                      initialValue: globalAdress,
                      decoration: const InputDecoration(
                        labelText: 'Adresse',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.draw,
                        ),
                      ),
                      onEditingComplete: () {
                        FirebaseFirestore.instance
                            .collection('IT-medarbeider')
                            .doc(globalDocId)
                            .update({'adresse': globalAdress})
                            .then((value) => print('Document updated'))
                            .catchError((error) =>
                                print('Failed to update document: $error'));
                        FocusScope.of(context).unfocus();
                      },
                      onChanged: (value) {
                        setState(() {
                          globalAdress = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 50,
                    child: TextFormField(
                      initialValue: globalTelefon,
                      decoration: const InputDecoration(
                        labelText: 'Telefon',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.draw,
                        ),
                      ),
                      onEditingComplete: () {
                        FirebaseFirestore.instance
                            .collection('IT-medarbeider')
                            .doc(globalDocId)
                            .update({'telefon': globalTelefon})
                            .then((value) => print('Document updated'))
                            .catchError((error) =>
                                print('Failed to update document: $error'));
                        FocusScope.of(context).unfocus();
                      },
                      onChanged: (value) {
                        setState(() {
                          globalTelefon = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 50,
                    child: TextFormField(
                      initialValue: globalBrukernavn,
                      decoration: const InputDecoration(
                        labelText: 'Brukernavn',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.draw,
                        ),
                      ),
                      onEditingComplete: () {
                        FirebaseFirestore.instance
                            .collection('IT-medarbeider')
                            .doc(globalDocId)
                            .update({'brukernavn': globalBrukernavn})
                            .then((value) => print('Document updated'))
                            .catchError((error) =>
                                print('Failed to update document: $error'));
                        FocusScope.of(context).unfocus();
                      },
                      onChanged: (value) {
                        setState(() {
                          globalBrukernavn = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 50,
                    child: TextFormField(
                      initialValue: globalDataId,
                      decoration: const InputDecoration(
                        labelText: 'Datamaskin Identifikasjon',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.draw,
                        ),
                      ),
                      onEditingComplete: () {
                        FirebaseFirestore.instance
                            .collection('IT-medarbeider')
                            .doc(globalDocId)
                            .update({'dataID': globalDataId})
                            .then((value) => print('Document updated'))
                            .catchError((error) =>
                                print('Failed to update document: $error'));
                        FocusScope.of(context).unfocus();
                      },
                      onChanged: (value) {
                        setState(() {
                          globalDataId = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 50,
                    child: TextFormField(
                      initialValue: globalDataAlder,
                      decoration: const InputDecoration(
                        labelText: 'Datamaskin Årsmodell',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.draw,
                        ),
                      ),
                      onEditingComplete: () {
                        FirebaseFirestore.instance
                            .collection('IT-medarbeider')
                            .doc(globalDocId)
                            .update({'dataAlder': globalDataAlder})
                            .then((value) => print('Document updated'))
                            .catchError((error) =>
                                print('Failed to update document: $error'));
                        FocusScope.of(context).unfocus();
                      },
                      onChanged: (value) {
                        setState(() {
                          globalDataAlder = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 50,
                    child: TextFormField(
                      initialValue: globalDataModell,
                      decoration: const InputDecoration(
                        labelText: 'Datamaskin Modell',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.draw,
                        ),
                      ),
                      onEditingComplete: () {
                        FirebaseFirestore.instance
                            .collection('IT-medarbeider')
                            .doc(globalDocId)
                            .update({'dataModell': globalDataModell})
                            .then((value) => print('Document updated'))
                            .catchError((error) =>
                                print('Failed to update document: $error'));
                        FocusScope.of(context).unfocus();
                      },
                      onChanged: (value) {
                        setState(() {
                          globalDataModell = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            )));
  }
}
