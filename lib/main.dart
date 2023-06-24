import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: CalculatorHomePage(title: '计算器'),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  CalculatorHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _display = '0';
  double _result = 0;
  String _operation = '';

  void _onDigitPress(String digit) {
    setState(() {
      if (_display == '0') {
        _display = digit;
      } else {
        _display += digit;
      }
    });
  }

  void _onOperationPress(String operation) {
    setState(() {
      _result = double.tryParse(_display) ?? 0;
      _operation = operation;
      _display = '0';
    });
  }

  void _onEqualsPress() {
    setState(() {
      double currentValue = double.tryParse(_display) ?? 0;

      switch (_operation) {
        case '+':
          _result += currentValue;
          break;
        case '-':
          _result -= currentValue;
          break;
        case '*':
          _result *= currentValue;
          break;
        case '/':
          if (currentValue != 0) {
            _result /= currentValue;
          }
          break;
      }
      _display = _result.toStringAsFixed(2);
      _operation = '';
    });
  }

  void _onClearPress() {
    setState(() {
      _display = '0';
      _result = 0;
      _operation = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(16),
              child: Text(
                _display,
                style: TextStyle(fontSize: 48),
              ),
            ),
          ),
          Row(
            children: [
              _buildButton('7', () => _onDigitPress('7')),
              _buildButton('8', () => _onDigitPress('8')),
              _buildButton('9', () => _onDigitPress('9')),
              _buildButton('/', () => _onOperationPress('/')),
            ],
          ),
          Row(
            children: [
              _buildButton('4', () => _onDigitPress('4')),
              _buildButton('5', () => _onDigitPress('5')),
              _buildButton('6', () => _onDigitPress('6')),
              _buildButton('*', () => _onOperationPress('*')),
            ],
          ),
          Row(
            children: [
              _buildButton('1', () => _onDigitPress('1')),
              _buildButton('2', () => _onDigitPress('2')),
              _buildButton('3', () => _onDigitPress('3')),
              _buildButton('-', () => _onOperationPress('-')),
            ],
          ),
          Row(
            children: [
              _buildButton('0', () => _onDigitPress('0')),
              _buildButton('.', () => _onDigitPress('.')),
              _buildButton('C', _onClearPress),
              _buildButton('+', () => _onOperationPress('+')),
            ],
          ),
          Row(
            children: [
              Expanded(child: Container()),
              _buildButton('=', _onEqualsPress),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(4),
        child: ElevatedButton(
          child: Text(
            label,
            style: TextStyle(fontSize: 24),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}