import 'package:flutter/material.dart';
import 'package:malugos_project/data/provider.dart';
import 'package:provider/provider.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  @override
  Widget build(BuildContext context) {
    final options = Provider.of<Options>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Row(
              children: [
                const Text('Ativar ou desativar Notificações'),
                const Spacer(),
                Switch(
                  value: options.notifications,
                  onChanged: (value) => options.changeNotifications(),
                )
              ],
            ),
          ),
          const ListTile(
            title: Text('Test'),
          ),
        ],
      ),
    );
  }
}
