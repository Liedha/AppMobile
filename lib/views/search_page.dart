import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/inspiration_viewmodel.dart';
import '../widgets/inspiration_list_item.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<InspirationViewModel>(context);
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Inspirations'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                //viewModel.searchInspirations(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.inspirations.length,
              itemBuilder: (context, index) {
                return InspirationListItem(inspiration: viewModel.inspirations[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
