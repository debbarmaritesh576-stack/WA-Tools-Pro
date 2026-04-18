import 'package:flutter/material.dart';  
import 'screens/home_screen.dart';  
  
void main() {  
  runApp(const MyApp());  
}  
  
class MyApp extends StatelessWidget {  
  const MyApp({super.key});  
  
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(  
      title: 'WA Tools Pro',  
      debugShowCheckedModeBanner: false,  
      theme: ThemeData(  
        colorScheme: ColorScheme.fromSeed(  
          seedColor: const Color(0xFF25D366),  
        ),  
        useMaterial3: true,  
      ),  
      darkTheme: ThemeData.dark().copyWith(  
        colorScheme: ColorScheme.fromSeed(  
          seedColor: const Color(0xFF25D366),  
          brightness: Brightness.dark,  
        ),  
      ),  
      themeMode: ThemeMode.system,  
      home: const HomeScreen(),  
    );  
  }  
}
