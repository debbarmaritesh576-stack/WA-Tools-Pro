import 'package:flutter/material.dart';  
import 'package:photo_manager/photo_manager.dart';  
import 'dart:io';  
  
class StatusSaverScreen extends StatefulWidget {  
  const StatusSaverScreen({super.key});  
  
  @override  
  State<StatusSaverScreen> createState() => _StatusSaverScreenState();  
}  
  
class _StatusSaverScreenState extends State<StatusSaverScreen> {  
  List<FileSystemEntity> _statuses = [];  
  bool _loading = true;  
  
  final List<String> _statusPaths = [  
    '/storage/emulated/0/WhatsApp/Media/.Statuses',  
    '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses',  
  ];  
  
  @override  
  void initState() {  
    super.initState();  
    _loadStatuses();  
  }  
  
  Future<void> _loadStatuses() async {  
    final permission = await PhotoManager.requestPermissionExtend();  
    if (!permission.isAuth) {  
      setState(() => _loading = false);  
      return;  
    }  
  
    List<FileSystemEntity> files = [];  
    for (String path in _statusPaths) {  
      final dir = Directory(path);  
      if (await dir.exists()) {  
        files = dir.listSync().where((f) =>  
          f.path.endsWith('.jpg') ||  
          f.path.endsWith('.mp4') ||  
          f.path.endsWith('.jpeg')  
        ).toList();  
        if (files.isNotEmpty) break;  
      }  
    }  
  
    setState(() {  
      _statuses = files;  
      _loading = false;  
    });  
  }  
  
  Future<void> _saveFile(String path) async {  
    final result = await PhotoManager.editor.saveImageWithPath(  
      path,  
      title: 'WA_Status_${DateTime.now().millisecondsSinceEpoch}',  
    );  
    if (result != null) {  
      ScaffoldMessenger.of(context).showSnackBar(  
        const SnackBar(content: Text('Status saved to gallery!')),  
      );  
    }  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Status Saver'),  
        backgroundColor: const Color(0xFF25D366),  
        foregroundColor: Colors.white,  
      ),  
      body: _loading  
          ? const Center(child: CircularProgressIndicator())  
          : _statuses.isEmpty  
              ? const Center(  
                  child: Text(  
                    'No statuses found!\nOpen WhatsApp and view statuses first.',  
                    textAlign: TextAlign.center,  
                    style: TextStyle(fontSize: 16),  
                  ),  
                )  
              : GridView.builder(  
                  padding: const EdgeInsets.all(8),  
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(  
                    crossAxisCount: 2,  
                    crossAxisSpacing: 8,  
                    mainAxisSpacing: 8,  
                  ),  
                  itemCount: _statuses.length,  
                  itemBuilder: (context, index) {  
                    final file = _statuses[index];  
                    final isVideo = file.path.endsWith('.mp4');  
                    return Stack(  
                      fit: StackFit.expand,  
                      children: [  
                        isVideo  
                            ? Container(  
                                color: Colors.black,  
                                child: const Icon(  
                                  Icons.play_circle,  
                                  color: Colors.white,  
                                  size: 48,  
                                ),  
                              )  
                            : Image.file(  
                                File(file.path),  
                                fit: BoxFit.cover,  
                              ),  
                        Positioned(  
                          bottom: 8,  
                          right: 8,  
                          child: GestureDetector(  
                            onTap: () => _saveFile(file.path),  
                            child: Container(  
                              padding: const EdgeInsets.all(6),  
                              decoration: const BoxDecoration(  
                                color: Color(0xFF25D366),  
                                shape: BoxShape.circle,  
                              ),  
                              child: const Icon(  
                                Icons.download,  
                                color: Colors.white,  
                                size: 20,  
                              ),  
                            ),  
                          ),  
                        ),  
                      ],  
                    );  
                  },  
                ),  
    );  
  }  
}
