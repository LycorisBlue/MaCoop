import 'package:flutter/material.dart';

class CooperativeListWidget extends StatelessWidget {
  final List<String> cooperativeImageUrls = [
    'https://i.pinimg.com/564x/8c/14/cf/8c14cf8b211219bd40e58e223a4ee700.jpg',
    'https://i.pinimg.com/564x/94/f4/d9/94f4d93b3b8f404dcb12232f1404be7a.jpg',
    'https://i.pinimg.com/564x/77/11/e5/7711e5ec546bb22473563f6fdfaf32e1.jpg',
    'https://i.pinimg.com/564x/e4/34/ea/e434ea1eee78a08980baf5703b4d2761.jpg', // Ajoutez plus d'URLs ici si nécessaire
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue John'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              // Action pour l'icône Accueil
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Action pour l'icône Quitter
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: 1000,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Action pour créer une coopérative
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 8.0),
                      Text('Créer une coopérative'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Liste de coopératives',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(30),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    padding: EdgeInsets.all(15.0),
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                    children: cooperativeImageUrls.map((url) {
                      return Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              url,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text('COOPERATIVE ${cooperativeImageUrls.indexOf(url) + 1}'),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}