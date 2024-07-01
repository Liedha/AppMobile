import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/inspiration_viewmodel.dart';
import '../widgets/inspiration_list_item.dart';
import '../widgets/custom_app_bar.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => InspirationViewModel()..fetchInspirations(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Daily Inspirations',
          showSearchButton: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.purple.shade100, Colors.white, Colors.purple.shade100],
            ),
          ),
          child: Consumer<InspirationViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (viewModel.inspirations.isEmpty) {
                return Center(child: Text('No inspirations found.', style: TextStyle(color: Colors.white)));
              }

              return RefreshIndicator(
                onRefresh: () async {
                  await viewModel.fetchInspirations();
                },
                child: ListView.builder(
                  padding: EdgeInsets.all(16.0),
                  itemCount: viewModel.inspirations.length,
                  itemBuilder: (context, index) {
                    return InspirationListItem(inspiration: viewModel.inspirations[index]);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}



