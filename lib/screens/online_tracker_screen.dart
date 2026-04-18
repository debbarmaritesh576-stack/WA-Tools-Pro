import 'package:flutter/material.dart';  
import 'package:shared_preferences/shared_preferences.dart';  
  
class OnlineTrackerScreen extends StatefulWidget {  
  const OnlineTrackerScreen({super.key});  
  
  @override  
  State<OnlineTrackerScreen> createState() => _OnlineTrackerScreenState();  
}  
  
class _OnlineTrackerScreenState extends State<OnlineTrackerScreen> {  
  final TextEditingController _phoneController = TextEditingController();  
  List<Map<String, String>> _trackedNumbers = [];  
  bool _isTracking = false;  
  
  @override  
  void initState() {  
    super.initState();  
    _loadNumbers();  
  }  
  
  Future<void> _loadNumbers() async {  
    final prefs = await SharedPreferences.getInstance();  
    final numbers = prefs.getStringList('tracked_numbers') ?? [];  
    setState(() {  
      _trackedNumbers = numbers.map((n) => {  
        'number': n,  
        'status': 'Checking...',  
        'lastSeen': 'Unknown',  
      }).toList();  
    });  
  }  
  
  Future<void> _addNumber() async {  
    final number = _phoneController.text.trim();  
    if (number.isEmpty) return;  
  
    final prefs = await SharedPreferences.getInstance();  
    final numbers = prefs.getStringList('tracked_numbers') ?? [];  
    numbers.add(number);  
    await prefs.setStringList('tracked_numbers', numbers);  
  
    setState(() {  
      _trackedNumbers.add({  
        'number': number,  
        'status': 'Tracking...',  
        'lastSeen': 'Unknown',  
      });  
      _phoneController.clear();  
    });  
  }  
  
  Future<void> _removeNumber(int index) async {  
    final prefs = await SharedPreferences.getInstance();  
    final numbers = prefs.getStringList('tracked_numbers') ?? [];  
    numbers.removeAt(index);  
    await prefs.setStringList('tracked_numbers', numbers);  
    setState(() => _trackedNumbers.removeAt(index));  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Online Tracker'),  
        backgroundColor: const Color(0xFF25D366),  
        foregroundColor: Colors.white,  
      ),  
      body: Padding(  
        padding: const EdgeInsets.all(16),  
        child: Column(  
          children: [  
            Container(  
              padding: const EdgeInsets.all(12),  
              decoration: BoxDecoration(  
                color: Colors.orange.withOpacity(0.1),  
                borderRadius: BorderRadius.circular(8),  
                border: Border.all(color: Colors.orange),  
              ),  
              child: const Row(  
                children: [  
                  Icon(Icons.warning, color: Colors.orange),  
                  SizedBox(width: 8),  
                  Expanded(  
                    child: Text(  
                      'Note: WhatsApp does not provide official API. This tracks last seen only if contact has enabled it.',  
                      style: TextStyle(fontSize: 12),  
                    ),  
                  ),  
                ],  
              ),  
            ),  
            const SizedBox(height: 16),  
            Row(  
              children: [  
                Expanded(  
                  child: TextField(  
                    controller: _phoneController,  
                    decoration: const InputDecoration(  
                      labelText: 'Enter number with country code',  
                      hintText: '+919876543210',  
                      border: OutlineInputBorder(),  
                    ),  
                    keyboardType: TextInputType.phone,  
                  ),  
                ),  
                const SizedBox(width: 8),  
                ElevatedButton(  
                  onPressed: _addNumber,  
                  style: ElevatedButton.styleFrom(  
                    backgroundColor: const Color(0xFF25D366),  
                    foregroundColor: Colors.white,  
                    minimumSize: const Size(60, 55),  
                  ),  
                  child: const Icon(Icons.add),  
                ),  
              ],  
            ),  
            const SizedBox(height: 16),  
            Expanded(  
              child: _trackedNumbers.isEmpty  
                  ? const Center(  
                      child: Text(  
                        'No numbers tracked!\nAdd a number to track.',  
                        textAlign: TextAlign.center,  
                        style: TextStyle(fontSize: 16),  
                      ),  
                    )  
                  : ListView.builder(  
                      itemCount: _trackedNumbers.length,  
                      itemBuilder: (context, index) {  
                        final item = _trackedNumbers[index];  
                        return Card(  
                          child: ListTile(  
                            leading: const CircleAvatar(  
                              backgroundColor: Color(0xFF25D366),  
                              child: Icon(  
                                Icons.person,  
                                color: Colors.white,  
                              ),  
                            ),  
                            title: Text(item['number']!),  
                            subtitle: Text('Last seen: ${item['lastSeen']}'),  
                            trailing: IconButton(  
                              icon: const Icon(  
                                Icons.delete,  
                                color: Colors.red,  
                              ),  
                              onPressed: () => _removeNumber(index),  
                            ),  
                          ),  
                        );  
                      },  
                    ),  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
}
