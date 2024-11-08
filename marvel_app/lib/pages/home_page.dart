import 'package:flutter/material.dart';
import 'package:marvel_app/pages/login_page.dart';
import 'package:marvel_app/pages/profile.dart';
import 'package:marvel_app/proveder/api_provider.dart';
import 'package:marvel_app/proveder/auth_provider.dart';
import 'package:marvel_app/widgets/card_stack.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<MovieProvider>(builder: (context, movieConsumer, child) {
      return SafeArea(
        child: Scaffold(
          drawer: Drawer(
            child: Column(
              children: [
               
              
                ListTile(
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ProfilePage();
                    }));
                  },
                ),
             
                ListTile(
                  title: const Text('Logout'),
                  onTap: () {
                    Provider.of<AuthentProvider>(context, listen: false)
                        .logout()
                        .then((value) {
                      if (value) {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return LogInPage();
                        }), (route) => false);
                      } else {
                        print("Logout failed");
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            actions: [
              SizedBox(
                width: 16,
              ),
          Image.asset("assets/FavoriteButton.png",  width: size.width * 0.06,),
              SizedBox(
                width: 8,
              ),
                IconButton(onPressed: () { 
                     Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ProfilePage();
                    }));

                 },
                icon:Image.asset("assets/InboxIcon.png",  width: size.width * 0.06,)), 
                
                
             
            ],
        
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Image.asset(
              "assets/image.png",
              width: size.width * 0.2,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.7),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: movieConsumer.movies.length,
                      itemBuilder: (context, index) {
                        return MovieCardStack(
                            movie: movieConsumer.movies[index]);

                        // MovieCard(movie: movieConsumer.movies[index]);
                      }),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class IconApp extends StatelessWidget {
  const IconApp({super.key, required this.icon, required this.function});
  final String icon;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            onPressed: () {
              function();
            },
            icon: Image.asset(
              icon,
              width: 24,
              height: 24,
            ),
          ),
        ),
      ],
    );
  }
}

class ScreenRouter extends StatefulWidget {
  const ScreenRouter({super.key});

  @override
  State<ScreenRouter> createState() => _ScreenRouterState();
}

class _ScreenRouterState extends State<ScreenRouter> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthentProvider>(builder: (context, authConsumer, child) {
      if (authConsumer.auth) {
        return HomePage();
      } else {
        return LogInPage();
      }
    });
  }
}