import 'package:flutter/material.dart';  
import 'package:url_launcher/url_launcher.dart';  
  
class DirectChatScreen extends StatefulWidget {  
  const DirectChatScreen({super.key});  
  
  @override  
  State<DirectChatScreen> createState() => _DirectChatScreenState();  
}  
  
class _DirectChatScreenState extends State<DirectChatScreen> {  
  final TextEditingController _phoneController = TextEditingController();  
  final TextEditingController _messageController = TextEditingController();  
  String _selectedCode = '+91';  
  
  final List<String> _countryCodes = [  
    '+91', '+1', '+44', '+61', '+971',  
    '+92', '+880', '+977', '+94', '+65',  
  ];  
  
  void _openWhatsApp() async {  
    final phone = _selectedCode + _phoneController.text.trim();  
    final message = _messageController.text.trim();  
    final url = Uri.parse(  
      'whatsapp://send?phone=${phone.replaceAll('+', '')}&text=${Uri.encodeComponent(message)}'  
    );  
    if (await canLaunchUrl(url)) {  
      await launchUrl(url);  
    } else {  
      ScaffoldMessenger.of(context).showSnackBar(  
        const SnackBar(content: Text('WhatsApp not installed!')),  
      );  
    }  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Direct Chat'),  
        backgroundColor: const Color(0xFF25D366),  
        foregroundColor: Colors.white,  
      ),  
      body: Padding(  
        padding: const EdgeInsets.all(16),  
        child: Column(  
          children: [  
            const Text(  
              'Chat without saving number!',  
              style: TextStyle(fontSize: 16),  
              textAlign: TextAlign.center,  
            ),  
            const SizedBox(height: 24),  
            Row(  
              children: [  
                DropdownButton<String>(  
                  value: _selectedCode,  
                  items: _countryCodes.map((code) {  
                    return DropdownMenuItem(  
                      value: code,  
                      child: Text(code),  
                    );  
                  }).toList(),  
                  onChanged: (val) {  
                    setState(() => _selectedCode = val!);  
                  },  
                ),  
                const SizedBox(width: 12),  
                Expanded(  
                  child: TextField(  
                    controller: _phoneController,  
                    decoration: const InputDecoration(  
                      labelText: 'Phone number',  
                      border: OutlineInputBorder(),  
                    ),  
                    keyboardType: TextInputType.phone,  
                  ),  
                ),  
              ],  
            ),  
            const SizedBox(height: 12),  
            TextField(  
              controller: _messageController,  
              decoration: const InputDecoration(  
                labelText: 'Message (optional)',  
                border: OutlineInputBorder(),  
              ),  
              maxLines: 3,  
            ),  
            const SizedBox(height: 24),  
            ElevatedButton.icon(  
              onPressed: _openWhatsApp,  
              icon: const Icon(Icons.chat),  
              label: const Text('Open WhatsApp'),  
              style: ElevatedButton.styleFrom(  
                backgroundColor: const Color(0xFF25D366),  
                foregroundColor: Colors.white,  
                minimumSize: const Size(double.infinity, 55),  
              ),  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
}
