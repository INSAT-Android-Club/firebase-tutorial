import 'package:firebase/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          color: ThemeModel().secondBackgroundColor,
          borderRadius:const BorderRadius.all(Radius.circular(14)),
        ),
      padding:const EdgeInsets.all(10),
      margin:const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: ClipRRect(
              borderRadius:const BorderRadius.all(Radius.circular(10)),
              child: FadeInImage(
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                placeholder: MemoryImage(kTransparentImage),
                image:const NetworkImage("https://www.korestudios.com/wp-content/uploads/2017/02/KoreStudios_Multilaser_Consumer_Electronics_04.jpg"),
              ),
            ),
          ),
          Expanded(
              child: Padding(
                padding:const EdgeInsetsDirectional.only(start: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Headphones",
                        style: theme.textTheme.headline5,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),



                    Padding(
                        padding:const EdgeInsets.only(top: 5),
                        child: Text(
                          "9\$",
                          style: theme.textTheme
                              .headline3,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        )),
                  ],
                ),
              )),
          GestureDetector(
            onTap: () {

            },
            child: Icon(

                   Icons.favorite_border_outlined,
              color:  ThemeModel().secondTextColor,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
