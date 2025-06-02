import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/SetWallpaper.dart' show setImage;

void main() {
  runApp(Wallpaper());
}

class Wallpaper extends StatefulWidget {
  const Wallpaper({super.key});

  @override
  State<Wallpaper> createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  List images = [];
  int pages = 1;

  @override
  void initState() {
    setState(() {
      fetchApi();
    });
  }

  fetchApi() async {
    await http
        .get(
      Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
      headers: {
        'Authorization':
        'fiirXVx2Dj7rF417BUAHYk7MIMZRrPhJkkwGyd33QO0maBXLCCZ3OBMS',
      },
    )
        .then((Value) {
      Map result = jsonDecode(Value.body);
      setState(() {
        images = result['photos'];
      });
    });
  }
  loadingMore() async{
    setState(() {
      pages +=1;
    });
    await http
        .get(
      Uri.parse('https://api.pexels.com/v1/curated?page=$pages&per_page=80'),
      headers: {
        'Authorization':
        'fiirXVx2Dj7rF417BUAHYk7MIMZRrPhJkkwGyd33QO0maBXLCCZ3OBMS',
      },
    ).then((Value) {
      Map result = jsonDecode(Value.body);
      setState(() {
        images.addAll(result['photos']);

      });
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: GridView.builder(
                  itemCount: images.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 2 / 3,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder:(context)=>setImage(ImageLink:images[index]['src']['tiny'] ,)));
                      },
                      child: Container(
                        color: Colors.white,
                        child: Image.network(
                          images[index]['src']['tiny'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            InkWell(
              onTap: (){
                loadingMore();

              },
              child: Container(
                color: Colors.blueGrey,
                height: 60,
                width: double.infinity,

                child: Center(
                  child: Text(
                    "Loading More",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
