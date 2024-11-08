import 'package:flutter/material.dart';
import 'package:marvel_app/helper/colors.dart';

import 'package:marvel_app/pages/login_page.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  
  State<Splash> createState() => _SplashState();
}


class _SplashState extends State<Splash> {
   
  @override
    void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_)=>(
          
           LogInPage())));
  }); 
    }
  @override
  Widget build(BuildContext context) {
   Size size=MediaQuery.of(context).size;
    return Scaffold(
      
      backgroundColor:redColor,
      body: Center(
        child: Image.asset('assets/marvelLogo.png',width: size.width*0.4,
        height: size.height*0.4,)

        ,

      )
    );
  }
}

 
