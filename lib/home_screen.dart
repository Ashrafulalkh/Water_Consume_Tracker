import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:water_intake_project/water_consume.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _glassCountController = TextEditingController(text: '1');

  List<WaterConsume> waterConsumeList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Consume Tracker'),
          centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 25, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  _buildWaterConsumeButton(),
                  const SizedBox(
                    height: 18,
                  ),
                  _buildNumberOfGlassesTextField(),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'History',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Total Count : ${_getTotalWaterCount()}',
                  style: const TextStyle(fontSize: 18),
                )
              ],
            ),
            const Divider(
              height: 20,
            ),
            _buildWaterTrackListView(),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberOfGlassesTextField() {
    return SizedBox(
                  width: 100,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _glassCountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'No of Glass',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                );
  }

  Widget _buildWaterConsumeButton() {
    return GestureDetector(
                  onTap: () {
                    _addWaterConsume();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.amber, width: 8),
                    ),
                    child: const Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Icon(
                              Icons.water_drop_outlined,
                              size: 32,
                            ),
                            Text('Tap Here'),
                          ],
                        )),
                  ),
                );
  }

  Widget _buildWaterTrackListView() {
    return Expanded(
            child: ListView.builder(
              // primary: false,
              //   shrinkWrap: true,
              itemCount: waterConsumeList.length,
              itemBuilder: (context, index) {
                return _buildSingleItemList(waterConsumeList[index],index + 0);
              },
            ),
          );
  }

  Widget _buildSingleItemList(WaterConsume waterConsume, int serialNo) {
    return ListTile(
                  title: Text(DateFormat.yMEd()
                      .add_jms()
                      .format(waterConsume.time)),
                  leading: CircleAvatar(
                    child: Text('${serialNo + 1}'),
                  ),
                  trailing: Text(
                    waterConsumeList[serialNo].glassCount.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
  }

  void _addWaterConsume() {
    int glassCount = int.tryParse(_glassCountController.text) ?? 1;
    WaterConsume waterConsume =
        WaterConsume(time: DateTime.now(), glassCount: glassCount);

    waterConsumeList.add(waterConsume);

    setState(() {});
  }

  int _getTotalWaterCount() {
    int totalCount = 0;
    for (WaterConsume waterConsume in waterConsumeList) {
      totalCount += waterConsume.glassCount;
    }
    return totalCount;
  }

  @override
  void dispose() {
    _glassCountController.dispose();
    super.dispose();
  }
}
