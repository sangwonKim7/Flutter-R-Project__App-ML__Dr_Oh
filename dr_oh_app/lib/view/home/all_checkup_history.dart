import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_oh_app/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllCheckupHistory extends StatelessWidget {
  const AllCheckupHistory({super.key});

  @override
  Widget build(BuildContext context) {
    // Desc: 조회한 날짜 표시
    var selectedDate = Get.arguments;

    return ListBody(
      selectedDate: selectedDate,
    );
  }
}

class ListBody extends StatefulWidget {
  final dynamic selectedDate;
  const ListBody({super.key, required this.selectedDate});

  @override
  State<ListBody> createState() => _ListBodyState();
}

class _ListBodyState extends State<ListBody> {
  late String id = '';
  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBar: AppBar(), title: '전체 검진기록 조회'),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              // .collection('result')
              // .orderBy('date', descending: false)
              // .where('userid', isEqualTo: id)
              // // .where('date', isEqualTo: widget.selectedDate.toString().substring(0, 10))
              // .snapshots(),
              .collection('result')
              .where('category')
              .where('userid', isEqualTo: id)
              .orderBy('date', descending: true) 
              .snapshots(includeMetadataChanges: true),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final documents = snapshot.data!.docs;
            return ListView(
              children: documents.map((e) => _buildItemWidget(e)).toList(),
            );
          }),
    );
  }

  _initSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString('id').toString();
    });
  }

  Widget _buildItemWidget(DocumentSnapshot doc) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete_forever),
      ),
      key: ValueKey(doc),
      onDismissed: (direction) {
        FirebaseFirestore.instance.collection('result').doc(doc.id).delete();
      },
      child: Card(
        color: Theme.of(context).primaryColorLight,
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 12, 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: const Color.fromARGB(255, 210, 221, 228),
                      width: 140,height: 32,
                      alignment: Alignment.center,
                      child: Text(
                        doc['date'],
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          '검진항목     ',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          doc['category'],
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColorDark),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      '결과     ',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${(double.parse(doc['result'].toString())).round()}',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: double.parse(doc['result'].toString()) >= 75
                            ? Colors.red
                            : double.parse(doc['result'].toString()) >= 50
                                ? Colors.orange
                                : double.parse(doc['result'].toString()) >= 25
                                    ? Colors.indigo
                                    : Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
