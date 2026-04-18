import 'package:flutter/material.dart';  
import 'package:flutter/services.dart';  
  
class TextFormatterScreen extends StatefulWidget {  
  const TextFormatterScreen({super.key});  
  
  @override  
  State<TextFormatterScreen> createState() => _TextFormatterScreenState();  
}  
  
class _TextFormatterScreenState extends State<TextFormatterScreen> {  
  final TextEditingController _textController = TextEditingController();  
  String _result = '';  
  
  void _format(String type) {  
    final text = _textController.text.trim();  
    if (text.isEmpty) return;  
    setState(() {  
      switch (type) {  
        case 'bold':  
          _result = '*$text*';  
          break;  
        case 'italic':  
          _result = '_${text}_';  
          break;  
        case 'strikethrough':  
          _result = '~$text~';  
          break;  
        case 'monospace':  
          _result = '```$text```';  
          break;  
        case 'upper':  
          _result = text.toUpperCase();  
          break;  
        case 'lower':  
          _result = text.toLowerCase();  
          break;  
        case 'reverse':  
          _result = text.split('').reversed.join();  
          break;  
        case 'bold_italic':  
          _result = '*_${text}_*';  
          break;  
      }  
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
        title: const Text('Text Formatter'),  
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
            const SizedBox(height: 16),  
            Wrap(  
              spacing: 8,  
              runSpacing: 8,  
              children: [  
                _buildButton('Bold', 'bold', Colors.green),  
                _buildButton('Italic', 'italic', Colors.blue),  
                _buildButton('Strike', 'strikethrough', Colors.red),  
                _buildButton('Mono', 'monospace', Colors.purple),  
                _buildButton('UPPER', 'upper', Colors.orange),  
                _buildButton('lower', 'lower', Colors.teal),  
                _buildButton('Reverse', 'reverse', Colors.pink),  
                _buildButton('Bold+Italic', 'bold_italic', Colors.indigo),  
              ],  
            ),  
            const SizedBox(height: 16),  
            if (_result.isNotEmpty) ...[  
              Container(  
                width: double.infinity,  
                padding: const EdgeInsets.all(12),  
                decoration: BoxDecoration(  
                  border: Border.all(color: Colors.grey),  
                  borderRadius: BorderRadius.circular(8),  
                ),  
                child: Text(  
                  _result,  
                  style: const TextStyle(fontSize: 16),  
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
  
  Widget _buildButton(String label, String type, Color color) {  
    return ElevatedButton(  
      onPressed: () => _format(type),  
      style: ElevatedButton.styleFrom(  
        backgroundColor: color,  
        foregroundColor: Colors.white,  
      ),  
      child: Text(label),  
    );  
  }  
}
