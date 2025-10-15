import 'package:flutter/material.dart';
import 'package:organizer/core/models/fix_transaction.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/presentation/state/fix_transaction_provider.dart';
import 'package:provider/provider.dart';

class FixTransactionElement extends StatefulWidget {
  const FixTransactionElement({super.key});

  @override
  State<FixTransactionElement> createState() => _FixTransactionElementState();
}

class _FixTransactionElementState extends State<FixTransactionElement> {
  Topic? _topic;
  List<FixTransaction> _fixTransactions = [];
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final topic = ModalRoute.of(context)!.settings.arguments as Topic;
    if (_topic != topic) {
      _topic = topic;
      _loadFixTransactions();
    }
  }

  Future<void> _loadFixTransactions() async {
    if (_topic == null) return;
    setState(() => _isLoading = true);
    final fixTransactionProvider = context.read<FixTransactionProvider>();
    final fixTransactions = await fixTransactionProvider
        .getAllFixTransactionsByTopic(_topic!);
    setState(() {
      _fixTransactions = fixTransactions;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _fixTransactions.isEmpty
          ? Text('There is no fix transactions')
          : Column(
              children: [
                ..._fixTransactions.map(
                  (f) => FixTransactionSubElement(fixTransaction: f),
                ),
              ],
            ),
    );
  }
}

class FixTransactionSubElement extends StatelessWidget {
  final FixTransaction fixTransaction;
  const FixTransactionSubElement({super.key, required this.fixTransaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(fixTransaction.value.toString()),
    );
  }
}
