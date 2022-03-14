import 'package:flutter/material.dart';
import 'package:mineswiper/puzzle/widgets/flag_lost.dart';
import 'package:mineswiper/puzzle/widgets/mine_lost.dart';
import 'package:mineswiper/utils/theme.dart';

class HowToPlay extends StatelessWidget {
  const HowToPlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/mine.png'),
              fit: BoxFit.fitHeight,
              height: 40,
              color: context.theme.textTheme.headline3!.color,
            ),
            Text(
              "MINESWIPER",
              style: context.theme.textTheme.headline3!.copyWith(
                fontFamily: "FredokaOne",
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              leading: MyBullet(),
              title: Text(
                "Mineswiper is a puzzle game inspired by famous game Minesweeper.",
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              leading: MyBullet(),
              title: Text(
                "In this game the player has to visit all tiles on the board in order to win.",
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              leading: MyBullet(),
              title: Text(
                "There are mines randomly distibuted underneath the tiles, player must flag the tile first"
                " so player can visit the mine tile.",
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MineLost(),
              ],
            ),
            ListTile(
              leading: MyBullet(),
              title: Text(
                "Player will lose the game if player wrongly flags the safe tile.",
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlagLost(),
              ],
            ),
            ListTile(
              leading: MyBullet(),
              title: Text(
                "Game will finish when player visits all tiles.",
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              leading: MyBullet(),
              title: Text(
                "Player can get hints, but it will add 5 seconds to the time and hints have 5 seconds of cooldown time.",
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              title: Text(
                "Controls",
                textAlign: TextAlign.center,
                style: context.theme.textTheme.headline5,
              ),
            ),
            ListTile(
              leading: MyBullet(),
              title: Text(
                "Player can click on the tile, make swipe gesture or use keyboard (using arrow keys) to move tile to whitespace",
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              leading: MyBullet(),
              title: Text(
                "Player can flag the tile by long pressing on the tile, player can also user 'W', 'A', 'S' and 'D' keys to flag "
                "the tiles (use 'W' to flag tile which is on top of whitespace, use 'S' to flag the tile at the bottom of the whitespace, use 'A' to flag the "
                "tile at the left of whitespace and use 'D' to flag tile at the right of the whitespace).",
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              leading: MyBullet(),
              title: Text(
                "It is possible to flag multiple tiles at once if mine number showing on whitespace is equal to remaining unopened tile, player can long press on whitespace to automatically flag the tiles"
                " also player can press 'F' key to automatically flag the tile if condition mentioned is met",
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              leading: MyBullet(),
              title: Text(
                "Player can press 'H' key to get the hint.",
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              title: Text(
                "Pro tips",
                textAlign: TextAlign.center,
                style: context.theme.textTheme.headline5,
              ),
            ),
            ListTile(
              leading: MyBullet(),
              title: Text(
                "At the start of the puzzle tap near center to have better chance of solving the puzzle",
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              leading: MyBullet(),
              title: Text(
                "Use auto flag feature to flag multiple tiles at once (long press on whitespace or press 'F' key)",
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              leading: MyBullet(),
              title: Text(
                "Enable memory mode in the settings to make puzzle more challenging.",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 20.0,
      width: 20.0,
      decoration: new BoxDecoration(
        color: context.theme.primaryColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
