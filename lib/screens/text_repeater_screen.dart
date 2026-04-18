import 'package:flutter/material.dart';  
import 'package:flutter/services.dart';  
  
class TextRepeaterScreen extends StatefulWidget {  
  const TextRepeaterScreen({super.key});  
  
  @override  
  State<TextRepeaterScreen> createState() => _TextRepeaterScreenState();  
}  
  
class _TextRepeaterScreenState extends State<TextRepeaterScreen> {  
  final TextEditingController _textController = TextEditingController();  
  final TextEditingController _countController = TextEditingController();  
  String _result = '';  
  
  void _repeat() {  
    final text = _textController.text;  
    final count = int.tryParse(_countController.text) ?? 1;  
    setState(() {  
      _result = (text + '\n') * count;  
    });  
  }  
  
  void _copy() {  
    Clipboard.setData(ClipboardData(text: _result));  
    ScaffoldMessenger.of(context).showSnackBar(  
      const SnackBar(content: Text('Copied!')),  
    );  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Text Repeater'),  
        backgroundColor: const Color(0xFF25D366),  
        foregroundColor: Colors.white,  
      ),  
      body: Padding(  
        padding: const EdgeInsets.all(16),  
        child: Column(  
          children: [  
            TextField(  
              controller: _textController,  
              decoration: const InputDecoration(  
                labelText: 'Enter text',  
                border: OutlineInputBorder(),  
              ),  
              maxLines: 3,  
            ),  
            const SizedBox(height: 12),  
            TextField(  
              controller: _countController,  
              decoration: const InputDecoration(  
                labelText: 'Repeat count',  
                border: OutlineInputBorder(),  
              ),  
              keyboardType: TextInputType.number,  
            ),  
            const SizedBox(height: 12),  
            ElevatedButton(  
              onPressed: _repeat,  
              style: ElevatedButton.styleFrom(  
                backgroundColor: const Color(0xFF25D366),  
                foregroundColor: Colors.white,  
                minimumSize: const Size(double.infinity, 50),  
              ),  
              child: const Text('Repeat'),  
            ),  
            const SizedBox(height: 12),  
            if (_result.isNotEmpty) ...[  
              Expanded(  
                child: Container(  
                  padding: const EdgeInsets.all(12),  
                  decoration: BoxDecoration(  
                    border: Border.all(color: Colors.grey),  
                    borderRadius: BorderRadius.circular(8),  
                  ),  
                  child: SingleChildScrollView(  
                    child: Text(_result),  
                  ),  
                ),  
              ),  
              const SizedBox(height: 12),  
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
            ],  
          ],  
        ),  
      ),  
    );  
  }  
}
