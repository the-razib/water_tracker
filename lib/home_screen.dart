
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:water_tracker/water_tracker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _noOfGlassTEController =
      TextEditingController(text: '1');

  List<WaterTracker> waterTrackerList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xff71C9CE),
      appBar: AppBar(
        title: const Text('Water Tracker',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.white),),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Text(
            _onTabWaterAddButton().toString(),
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w600,color: Colors.white),
          ),
          const Text(
            'Glasses',
            style: TextStyle(fontSize: 28, color: Colors.white,fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 48,
                child: TextField(
                  controller: _noOfGlassTEController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  _onTabWaterTracker();
                },
                child: const Text('Add'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Card(
                color: Colors.white,
                elevation: 2,
                child: _infocard(),
              ),
            ),
          )
        ],
      ),
    );
  }

  int _onTabWaterAddButton() {
    int count = 0;
    for (WaterTracker t in waterTrackerList) {
      count += t.noOfGlass;
    }
    return count;
  }

  Widget _infocard() {
    return ListView.separated(
        itemBuilder: (context, int index) {
          WaterTracker waterTracker = waterTrackerList[index];
          return _buildListViewCard(waterTracker , index);
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(),
        itemCount: waterTrackerList.length);
  }

  Widget _buildListViewCard(WaterTracker waterTracker, int index) {
    // Formatting the time and date using intl
    String formattedTime = DateFormat('hh:mm a')
        .format(waterTracker.dateTime); // Time in 12-hour format
    String formattedDate = DateFormat('dd-MMM-yyyy')
        .format(waterTracker.dateTime); // Date like 14-Sep-2024
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        child: ListTile(
          tileColor: const Color(0xffE3FDFD),
          title: Text(
              formattedTime),
          subtitle: Text(
              formattedDate),
          trailing:
              IconButton(onPressed: () {
                _onTabDelete(index);
              }, icon: const Icon(Icons.delete_outline)),
          leading: CircleAvatar(
            backgroundColor: const Color(0xff71C9CE),
            child: Text('${waterTracker.noOfGlass}',),
          ),
        ),
      ),
    );
  }

  void _onTabDelete(int index) {
    waterTrackerList.removeAt(index);
    setState(() {});
  }

  void _onTabWaterTracker() {
    if (_noOfGlassTEController.text.isEmpty) {
      _noOfGlassTEController.text = '1';
    }
    final int noOfGlass = int.tryParse(_noOfGlassTEController.text) ?? 1;
    WaterTracker waterTracker =
        WaterTracker(noOfGlass: noOfGlass, dateTime: DateTime.now());
    waterTrackerList.add(waterTracker);
    setState(() {});
  }
}
