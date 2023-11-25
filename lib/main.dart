import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TicTacToePage(),
    );
  }
}

class TicTacToePage extends StatefulWidget {
  const TicTacToePage({super.key});
  
  @override
  State<TicTacToePage> createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  List<String> board = List.generate(9, (index) => '');
  String currentPlayer = 'X';
  Random random = Random();

  void _handleTap(int index) {
    if (board[index] != '' || _checkWinCondition() != '') {
      return;
    }

    setState(() {
      board[index] = currentPlayer;
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      if (!_checkWinCondition().isNotEmpty) {
        _computerMove();
      }
    });
  }

  void _computerMove() {
    // 电脑随机选择一个空位置
    List<int> availableMoves = [];
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        availableMoves.add(i);
      }
    }

    if (availableMoves.isNotEmpty) {
      final move = availableMoves[random.nextInt(availableMoves.length)];
      board[move] = currentPlayer;
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    }
  }

  String _checkWinCondition() {
    // 检查胜利条件
    const winConditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var condition in winConditions) {
      if (board[condition[0]] == board[condition[1]] &&
          board[condition[1]] == board[condition[2]] &&
          board[condition[0]] != '') {
        return board[condition[0]];
      }
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1, // 使GridView为正方形
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _handleTap(index),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      board[index],
                      style: const TextStyle(fontSize: 64),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}
