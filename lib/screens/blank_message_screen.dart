import 'package:flutter/material.dart';  
import 'package:flutter/services.dart';  
import 'package:url_launcher/url_launcher.dart';  
  
class BlankMessageScreen extends StatefulWidget {  
  const BlankMessageScreen({super.key});  
  
  @override  
  State<BlankMessageScreen> createState() => _BlankMessageScreenState();  
}  
  
class _BlankMessageScreenState extends State<BlankMessageScreen> {  
  final TextEditingController _countController = TextEditingController();  
  String _blankText = '';  
  
  void _generate() {  
    final count = int.tryParse(_countController.text) ?? 1;  
    setState(() {  
      _blankText = '‎ ' * count;  
    });  
  }  
  
  void _copy() {  
    Clipboard.setData(ClipboardData(text: _blankText));  
    ScaffoldMessenger.of(context).showSnackBar(  
      const SnackBar(content: Text('Copied! Paste in WhatsApp')),  
    );  
  }  
  
  void _sendDirectly() async {  
    final url = Uri.parse('whatsapp://send?text=${Uri.encodeComponent(_blankText)}');  
    if (await canLaunchUrl(url)) {  
      await launchUrl(url);  
    }  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Blank Message'),  
        backgroundColor: const Color(0xFF25D366),  
        foregroundColor: Colors.white,  
      ),  
      body: Padding(  
        padding: const EdgeInsets.all(16),  
        child: Column(  
          children: [  
            const Text(  
              'Send blank/empty message on WhatsApp!',  
              style: TextStyle(fontSize: 16),  
              textAlign: TextAlign.center,  
            ),  
            const SizedBox(height: 24),  
            TextField(  
              controller: _countController,  
              decoration: const InputDecoration(  
                labelText: 'How many blank lines?',  
                border: OutlineInputBorder(),  
              ),  
              keyboardType: TextInputType.number,  
            ),  
            const SizedBox(height: 12),  
            ElevatedButton(  
              onPressed: _generate,  
              style: ElevatedButton.styleFrom(  
                backgroundColor: const Color(0xFF25D366),  
                foregroundColor: Colors.white,  
                minimumSize: const Size(double.infinity, 50),  
              ),  
              child: const Text('Generate'),  
            ),  
            const SizedBox(height: 12),  
            if (_blankText.isNotEmpty) ...[  
              ElevatedButton.icon(  
                onPressed: _copy,  
                icon: const Icon(Icons.copy),  
                label: const Text('Copy'),  
                style: ElevatedButton.styleFrom(  
                  backgroundColor: Colors.teal,  
                  foregroundColor: Colors.white,  
                  minimumSize: const Size(double.infinity, 50),  
                ),  
              ),  
              const SizedBox(height: 12),  
              ElevatedButton.icon(  
                onPressed: _sendDirectly,  
                icon: const Icon(Icons.send),  
                label: const Text('Send on WhatsApp'),  
                style: ElevatedButton.styleFrom(  
                  backgroundColor: Colors.green,  
                  foregroundColor: Colors.white,  
                  minimumSize: const Size(double.infinity, 50),  
                ),  
              ),  
            ],  
          ],  
        ),  
      ),  
    );  
  }  
}
