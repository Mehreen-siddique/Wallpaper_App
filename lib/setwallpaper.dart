import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/material.dart';


class setImage extends StatefulWidget {
  const setImage({super.key, required this.ImageLink});

  final String ImageLink;
  @override
  State<setImage> createState() => _setImageState();
}

class _setImageState extends State<setImage> {

  Future<void> setWallpaper() async{
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.ImageLink);
    final Future<bool> result = WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:
        Column(
          children: [
            Expanded(
              child: Container(
                child: Image.network(widget.ImageLink,fit: BoxFit.cover,),
              ),),
            InkWell(
              onTap: (){
                setWallpaper();
              },
              child: Container(
                color: Colors.blueGrey,
                height: 60,
                width: double.infinity,

                child: Center(
                    child: Text(
                      "Set As Wallpaper",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                ),
              ),
            ),


          ],
        ),
      ),

    );
  }
}
