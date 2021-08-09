import 'package:flutter/material.dart';
import 'package:kilifi_county/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ECitizenScreen extends StatefulWidget {
  static const routeName = '/e-citizen';

  @override
  _ECitizenScreenState createState() => _ECitizenScreenState();
}

class _ECitizenScreenState extends State<ECitizenScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Text(
                  'e-Citizen Services',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ECitizenTile(
                list: payList,
                title: 'Pay for',
              ),
              ECitizenTile(
                title: 'Apply for',
                list: applyList,
              ),
              ECitizenTile(
                title: 'Get/View',
                list: getView,
              ),
              ECitizenTile(
                title: 'Register as',
                list: register,
              ),
              ECitizenTile(
                title: 'Report on',
                list: report,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ECitizenTile extends StatefulWidget {
  final List list;
  final String title;
  ECitizenTile({this.list, this.title});
  @override
  _ECitizenTileState createState() => _ECitizenTileState();
}

class _ECitizenTileState extends State<ECitizenTile> {
  String defaultValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
                onChanged: (value) {
                  setState(() {
                    defaultValue = value;
                  });
                },
                hint: Text('${widget.title}...'),
                isExpanded: true,
                value: defaultValue,
                icon: Icon(Icons.keyboard_arrow_down),
                items: widget.list
                    .map((e) => DropdownMenuItem(
                          onTap: () async {
                            await canLaunch(e['url'])
                                ? await launch(e['url'])
                                : throw 'Could not launch ${e['url']}';
                          },
                          child: Text(e['title']),
                          value: e['title'],
                        ))
                    .toList()),
          ),
        ),
      ),
    );
  }
}

List payList = [
  {'title': 'Licence Fee', 'url': 'https://selfservice.kilifi.go.ke/'},
  {'title': 'Rates', 'url': 'https://selfservice.kilifi.go.ke/'},
];
List applyList = [
  {
    'title': 'Access to Govt. Procurement(AGPO)',
    'url': 'https://www.kilifi.go.ke/library.php?com=7&com2=65&com3=73&com4='
  },
  {
    'title': 'Inspection of facilities',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Apply_For&form=Inspection%20of%20Facilities#'
  },
  {
    'title': 'Bursary',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Apply_For&form=Bursary#'
  },
  {
    'title': 'Permit',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Apply_For&form=Permit#'
  },
  {
    'title': 'Licence.',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Apply_For&form=License#'
  },
];
List getView = [
  {
    'title': 'County Publications',
    'url': 'https://www.kilifi.go.ke/library.php?com=5&com2=69&com3=49&com4='
  },
  {
    'title': 'Public Records',
    'url': 'https://www.kilifi.go.ke/library.php?com=5&com2=69&com3=6&com4=#'
  },
  {
    'title': 'Directory of Information Services',
    'url': 'https://www.kilifi.go.ke/content.php?com=7&com2=66&com3=#'
  },
];

List register = [
  {
    'title': 'Business/Service Provider/Vendor',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Register_As&form=Business%20/%20Service%20Provider%20/%20Vendor#'
  },
  {
    'title': 'ECD Center',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Register_As&form=ECD%20Center#'
  },
  {
    'title': 'Citizen',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Register_As&form=Citizen#'
  },
  {
    'title': 'Farmer',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Register_As&form=Farmer#'
  },
  {
    'title': 'Professional',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Register_As&form=Professional#'
  },
  {
    'title': 'SACCO',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Register_As&form=SACCO#'
  },
  {
    'title': 'NGO',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Register_As&form=NGO#'
  },
  {
    'title': 'Supporter of Causes',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Register_As&form=Supporter%20of%20Causes#'
  },
  {
    'title': 'Support Group',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Register_As&form=Support%20Group#'
  },
  {
    'title': 'Sponsor(Sponsor/Adopt a School',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Register_As&form=Sponsor%20(Sponsor%20/%20Adopt%20a%20School)'
  },
  {
    'title': 'Primary School',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Register_As&form=Primary%20School#'
  },
  {
    'title': 'Polytechnic',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Register_As&form=Polytechnic#'
  },
];

List report = [
  {
    'title': 'Corruption or Fraud from County Employee/Vendor',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Report&form=Corruption%20or%20Fraud%20by%20County%20Employee/Vendor#'
  },
  {
    'title': 'Business Overcharge',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Report&form=Business%20Overcharge#'
  },
  {
    'title': 'Child Abuse',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Report&form=Child%20Abuse#'
  },
  {
    'title': 'Crime',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Report&form=Crime#'
  },
  {
    'title': 'Drug Abuse',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Report&form=Drug%20Abuse#'
  },
  {
    'title': 'Disability Complaint Against County',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Report&form=Disability%20Complaint%20Against%20County#'
  },
  {
    'title': 'Illegal Dumping',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Report&form=Illegal%20Dumping#'
  },
  {
    'title': 'Law Enforcement Complaint',
    'url':
        'https://www.kilifi.go.ke/onlineservice.php?com=66&sel=Report&form=Law%20Enforcement%20Complaint#'
  },
];
