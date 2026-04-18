import 'package:flutter/material.dart';  
import 'text_repeater_screen.dart';  
import 'blank_message_screen.dart';  
import 'direct_chat_screen.dart';  
import 'text_formatter_screen.dart';  
import 'status_saver_screen.dart';  
import 'online_tracker_screen.dart';  
  
class HomeScreen extends StatelessWidget {  
  const HomeScreen({super.key});  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text(  
          'WA Tools Pro',  
          style: TextStyle(  
            fontWeight: FontWeight.bold,  
            color: Colors.white,  
          ),  
        ),  
        backgroundColor: const Color(0xFF25D366),  
      ),  
      body: GridView.count(  
        crossAxisCount: 2,  
        padding: const EdgeInsets.all(16),  
        crossAxisSpacing: 16,  
        mainAxisSpacing: 16,  
        children: [  
          _buildTile(context, 'Text Repeater', Icons.repeat, Colors.green, const TextRepeaterScreen()),  
          _buildTile(context, 'Blank Message', Icons.message, Colors.teal, const BlankMessageScreen()),  
          _buildTile(context, 'Direct Chat', Icons.chat, Colors.blue, const DirectChatScreen()),  
          _buildTile(context, 'Text Formatter', Icons.text_fields, Colors.purple, const TextFormatterScreen()),  
          _buildTile(context, 'Status Saver', Icons.download, Colors.orange, const StatusSaverScreen()),  
          _buildTile(context, 'Online Tracker', Icons.track_changes, Colors.red, const OnlineTrackerScreen()),  
        ],  
      ),  
    );  
  }  
  
  Widget _buildTile(BuildContext context, String title, IconData icon, Color color, Widget screen) {  
    return GestureDetector(  
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),  
      child: Container(  
        decoration: BoxDecoration(  
          color: color.withOpacity(0.1),  
          borderRadius: BorderRadius.circular(16),  
          border: Border.all(color: color, width: 1.5),  
        ),  
        child: Column(  
          mainAxisAlignment: MainAxisAlignment.center,  
          children: [  
            Icon(icon, size: 48, color: color),  
            const SizedBox(height: 12),  
            Text(  
              title,  
              style: TextStyle(  
                fontSize: 14,  
                fontWeight: FontWeight.bold,  
                color: color,  
              ),  
              textAlign: TextAlign.center,  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
}
