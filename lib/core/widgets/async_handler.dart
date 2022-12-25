import 'package:tiutiu/core/widgets/loading_page.dart';
import 'package:tiutiu/core/widgets/error_page.dart';
import 'package:tiutiu/core/widgets/empty_list.dart';
import 'package:flutter/material.dart';

class AsyncHandler<T> extends StatelessWidget {
  const AsyncHandler({
    this.forceReturnBuildWidget = false,
    this.showClearFiltersButton = true,
    this.showLoadingScreen = true,
    required this.buildWidget,
    this.forcedDataReturned,
    required this.snapshot,
    this.onErrorCallback,
    this.loadingMessage,
    this.noResultScreen,
    this.errorMessage,
    this.emptyMessage,
    this.emptyWidget,
    this.errorWidget,
    super.key,
  }) : assert(forceReturnBuildWidget ? forcedDataReturned != null : forcedDataReturned == null);

  final Widget Function(T data) buildWidget;
  final void Function()? onErrorCallback;
  final bool showClearFiltersButton;
  final bool forceReturnBuildWidget;
  final AsyncSnapshot<T> snapshot;
  final Widget? noResultScreen;
  final String? loadingMessage;
  final bool showLoadingScreen;
  final T? forcedDataReturned;
  final String? errorMessage;
  final String? emptyMessage;
  final Widget? errorWidget;
  final Widget? emptyWidget;

  Widget _handleSnapshotState() {
    final ConnectionState connectionState = snapshot.connectionState;

    if (snapshot.hasError) {
      debugPrint('>> Error ao carregar dados do tipo $T. Message: ${snapshot.error} ${snapshot.stackTrace}');
      return errorWidget ??
          ErrorPage(
            onErrorCallback: onErrorCallback,
            errorMessage: errorMessage,
            error: snapshot.error,
          );
    }
    if (connectionState == ConnectionState.waiting && showLoadingScreen) return LoadingPage();

    if (forceReturnBuildWidget) return buildWidget(forcedDataReturned!);

    if (!snapshot.hasData || snapshot.data == null) {
      return Center(
        child: noResultScreen ??
            emptyWidget ??
            EmptyListScreen(
              text: emptyMessage,
              showClearFiltersButton: showClearFiltersButton,
            ),
      );
    }

    if (snapshot.data is List && (snapshot.data as List).isEmpty) {
      return Center(
        child: noResultScreen ??
            emptyWidget ??
            EmptyListScreen(
              text: emptyMessage,
              showClearFiltersButton: showClearFiltersButton,
            ),
      );
    }

    return forceReturnBuildWidget ? buildWidget(forcedDataReturned!) : buildWidget(snapshot.data!);
  }

  @override
  Widget build(BuildContext context) => _handleSnapshotState();
}
