import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salei/components/app_bar.dart';
import 'package:salei/components/bottom_bar_navigation.dart';
import 'package:salei/components/empty.dart';
import 'package:salei/core/launcher/lauch_call.dart';
import 'package:salei/datas/datasources/get_remote_pharmacies.dart';
import 'package:salei/models/medicament.dart';

class ResultatsPharmacie extends StatefulWidget {
  final String medicament;

  const ResultatsPharmacie({Key key, @required this.medicament})
      : super(key: key);
  @override
  _ResultatsPharmacieState createState() => _ResultatsPharmacieState();
}

class _ResultatsPharmacieState extends State<ResultatsPharmacie> {
  List<Medicament> _medicaments = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarOtherPage(context),
      bottomNavigationBar: bottomBarNavigation(context),
      body: FutureBuilder(
        future: GetDrug().getRemoteDrug(widget.medicament),
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.hasData) {
            _medicaments = snapshot.data;
            return (_medicaments.isEmpty)
                ? Empty(
                    message:
                        'Aucun médicament retrouvé dans les pharmacies abonnés',
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            '${_medicaments.length} médicaments retrouvés près de vous',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async => true,
                            child: ListView.builder(
                              itemCount: _medicaments.length,
                              itemBuilder: (context, index) {
                                Medicament medicament = _medicaments[index];
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(width: .2),
                                    ),
                                  ),
                                  child: ListTile(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 0),
                                    leading: CircleAvatar(
                                      child: Text(
                                        medicament.pharmacieNom.name
                                            .substring(0, 1)
                                            .toUpperCase(),
                                      ),
                                    ),
                                    onTap: () {
                                      // Redirection vers les détails de la pharmacie
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => PharmacieInfo(
                                      //       medicament: medicament,
                                      //     ),
                                      //   ),
                                      // );
                                    },
                                    title: Text(medicament.nom),
                                    subtitle:
                                        Text(medicament.pharmacieNom.name),
                                    trailing: IconButton(
                                      icon:
                                          Icon(Icons.call, color: Colors.green),
                                      onPressed: () {
                                        // On redirrige vers la numérotation pour appeler la pharmacie
                                        LaunchCall().makePhoneCall(
                                          medicament.pharmacieNom.telephone,
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  );
          } else {
            return Center(
              child: CupertinoActivityIndicator(radius: 15),
            );
          }
        },
      ),
    );
  }
}
