Product listing with collapsible header, sticky tab bar, horizontal swipe, and FakeStore API auth.

## Run

```bash
flutter pub get
flutter run
```

> **Test Login:** `mor_2314` / `83r5^_`

## Scroll Architecture

`NestedScrollView` provides **one vertical scrollable** for the entire screen.

- **Header:** `SliverAppBar` (collapsible) + `SliverPersistentHeader` with `pinned: true` (sticky tab bar).
- **Body:** `TabBarView` containing a `CustomScrollView` per tab.
- **Scroll ownership:** `NestedScrollView` owns the outer controller and coordinates the handoff — header collapses first, then inner tab content scrolls. No jitter or duplicate scrolling.

## Horizontal Swipe

`TabBarView` (body of `NestedScrollView`) handles horizontal swipe via its internal `PageView`. Flutter's gesture arena disambiguates horizontal vs. vertical drags, so there is **no gesture conflict**. Tabs are also switchable by tapping the `TabBar`; a shared `TabController` keeps both in sync.

## Tab State Preservation

Each tab uses `AutomaticKeepAliveClientMixin` to prevent disposal on tab switch, preserving widget state and scroll position.

## Pull-to-Refresh

`RefreshIndicator` wraps the entire `NestedScrollView`, so pull-to-refresh works **from any tab** via the unified outer scroll.

## Dependencies

| Package | Purpose |
|---|---|
| `flutter_bloc` | State management (BLoC) |
| `dio` | HTTP networking |
| `equatable` | Value equality for models & states |
| `cached_network_image` | Image caching |
| `shimmer` | Loading skeleton animations |
| `dartx` | Commonly used extensions |
