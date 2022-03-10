import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitalize/models/hospital.dart';
import 'package:hospitalize/widgets/hospital_card.dart';

class SearchHospital extends StatefulWidget {
  const SearchHospital({Key? key}) : super(key: key);
  static const routeName = '/search-hospital';

  @override
  State<SearchHospital> createState() => _SearchHospitalState();
}

class _SearchHospitalState extends State<SearchHospital> {
  bool _isSearch = false;
  String? searchData;
  final hospitalData = Hospital.hospitalsList;
  var filterData = [];

  AppBar get appBar => AppBar(
        title: _isSearch
            ? TextField(
                onChanged: (s) {
                  setState(() {
                    searchData = s;
                    filterData = hospitalData
                        .where(
                            (element) => element.name!.startsWith(searchData!))
                        .toList();
                  });
                },
                cursorColor: Colors.white,
                enableInteractiveSelection: true,
                style: const TextStyle(color: Colors.white),
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Enter text to search..',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white60),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              )
            : const Text('Search Hospital'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _isSearch = !_isSearch;
                  if (!_isSearch) searchData = '';
                });
              },
              child: _isSearch
                  ? const Icon(Icons.close)
                  : const Icon(Icons.search),
            ),
          ),
        ],
      );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var val = ModalRoute.of(context)!.settings.arguments;
    print(val);
    return Scaffold(
      appBar: appBar,
      body: _isSearch
          ? ListView.builder(
              itemCount: filterData.length,
              itemBuilder: (ctx, index) {
                final data = filterData.elementAt(index);
                return InkWell(
                  onTap: () {
                    if (val != null && val == true) {
                      Navigator.pop(context, data);
                    }
                  },
                  child: HospitalCard(data: data),
                );
              },
            )
          : ListView.builder(
              itemCount: hospitalData.length,
              itemBuilder: (ctx, index) {
                final data = hospitalData.elementAt(index);
                return InkWell(
                  onTap: () {
                    if (val != null && val == true) {
                      Navigator.pop(context, data);
                    }
                  },
                  child: HospitalCard(data: data),
                );
              },
            ),
    );
  }
}

/*
FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
          future: Hospital().hospitals(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong!'));
            } else {
              snapshot.data!
                  .removeWhere((element) => element['verified'] == 'No');
              Iterable<QueryDocumentSnapshot<Map<String, dynamic>>>?
                  filteredData;
              if (searchData != null) {
                filteredData = snapshot.data!.where((element) =>
                    element['name'].toString().startsWith(searchData!));
              }
              return _isSearch
                  ? ListView.builder(
                      itemCount: filteredData?.length,
                      itemBuilder: (ctx, index) {
                        final data = filteredData!.elementAt(index).data();
                        return HospitalCard(data: data);
                      },
                    )
                  : ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (ctx, index) {
                        final data = snapshot.data!.elementAt(index).data();
                        return HospitalCard(data: data);
                      },
                    );
            }
          }),
*/
