import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/result.dart';
import '../../results/widgets/results_screen.dart';
import '../view_models/search_form_viewmodel.dart';

/// Search form submit button
///
/// The button is disabled when the form is data is incomplete.
/// When tapped, it navigates to the [ResultsScreen]
/// passing the search options as query parameters.
class SearchFormSubmit extends StatelessWidget {
  const SearchFormSubmit({
    super.key,
    required this.viewModel,
  });

  final SearchFormViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ListenableBuilder(
        listenable: viewModel,
        child: const SizedBox(
          height: 52,
          child: Center(
            child: Text('Search'),
          ),
        ),
        builder: (context, child) {
          return FilledButton(
            key: const ValueKey('submit_button'),
            onPressed: viewModel.valid
                ? () async {
                    await viewModel.updateItineraryConfig.execute(
                      onComplete: (result) {
                        if (result) {
                          context.go('/results');
                        }
                      },
                    );
                  }
                : null,
            child: child,
          );
        },
      ),
    );
  }
}
