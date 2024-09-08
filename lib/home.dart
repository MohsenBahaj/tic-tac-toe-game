import 'package:flutter/material.dart';
import 'package:tic/game_logic.dart';

// Home widget to display the game
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String activePlayer = Player.x;
  bool gameOver = false;
  int turn = 0;
  String result = ' ';
  Game game = Game();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: SafeArea(
        child: Column(
          children: [
            SwitchListTile.adaptive(
              value: isSwitched,
              title: Text(
                'Turn on/off two players',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onChanged: (newValue) {
                setState(() {
                  isSwitched = newValue;
                });
              },
            ),
            Text(
              "It's $activePlayer Turn".toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Expanded(
              child: GridView.count(
                padding: EdgeInsets.all(16),
                crossAxisCount: 3,
                crossAxisSpacing: 3,
                childAspectRatio: 1.0,
                mainAxisSpacing: 3,
                children: List.generate(9, (index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: gameOver ? null : () => _onTap(index),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context).shadowColor,
                      ),
                      child: Center(
                        child: Text(
                          Player.playerX.contains(index)
                              ? 'X'
                              : Player.playerO.contains(index)
                                  ? 'O'
                                  : '',
                          style: TextStyle(
                            color: Player.playerX.contains(index)
                                ? Colors.blue
                                : Colors.red,
                            fontSize: 55,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Text(
              'Result : $result',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            ElevatedButton.icon(
              onPressed: _resetGame,
              icon: Icon(Icons.repeat),
              label: Text('Play Again'),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).splashColor),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(int index) async {
    if ((Player.playerX.isEmpty || !Player.playerX.contains(index)) &&
        (Player.playerO.isEmpty || !Player.playerO.contains(index))) {
      game.playGame(index, activePlayer);
      updateState();

      String winner = game.checkWinner();
      if (winner.isNotEmpty) {
        setState(() {
          gameOver = true;
          result = '$winner is the Winner!';
        });
        return;
      }

      if (turn == 8) {
        setState(() {
          gameOver = true;
          result = "It's a Draw!";
        });
      }

      if (!isSwitched && !gameOver) {
        await game.autoPlay(activePlayer);
        updateState();

        winner = game.checkWinner();
        if (winner.isNotEmpty) {
          setState(() {
            gameOver = true;
            result = '$winner is the Winner!';
          });
        }
      }
    }
  }

  void updateState() {
    setState(() {
      activePlayer = activePlayer == Player.x ? Player.o : Player.x;
      turn++;
    });
  }

  void _resetGame() {
    setState(() {
      activePlayer = Player.x;
      gameOver = false;
      turn = 0;
      result = '';
      Player.playerX = [];
      Player.playerO = [];
    });
  }
}
