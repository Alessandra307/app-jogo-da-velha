import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jogo da Velha',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicTacToePage(),
    );
  }
}

class TicTacToePage extends StatefulWidget {
  @override
  _TicTacToePageState createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  List<String?> board = List.filled(9, null);
  bool isXNext = true;
  String? winner;

  void _handleTap(int index) {
    if (board[index] != null || winner != null) return;

    setState(() {
      board[index] = isXNext ? 'X' : 'O';
      isXNext = !isXNext;
      winner = _checkWinner();
    });
  }

  String? _checkWinner() {
    const List<List<int>> winningPositions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var positions in winningPositions) {
      final a = positions[0];
      final b = positions[1];
      final c = positions[2];

      if (board[a] != null && board[a] == board[b] && board[a] == board[c]) {
        return board[a];
      }
    }

    if (!board.contains(null)) {
      return 'Empate';
    }

    return null;
  }

  void _resetGame() {
    setState(() {
      board = List.filled(9, null);
      isXNext = true;
      winner = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo da Velha'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: 9,
            shrinkWrap: true,
            padding: EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _handleTap(index),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      board[index] ?? '',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: board[index] == 'X' ? Colors.blue : Colors.red,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          if (winner != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                winner == 'Empate' ? 'Empate!' : 'Jogador $winner venceu!',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
          ElevatedButton(
            onPressed: _resetGame,
            child: Text('Reiniciar Jogo'),
          ),
        ],
      ),
    );
  }
}
