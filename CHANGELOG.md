## 0.0.9

### 🐛 Bug Fixes

- **Fixed date reset on column change**: Previously, selecting a day (e.g., 10) and then scrolling to change the month would reset the day back to 1. Now the selected day is preserved when switching between year, month, and day columns.
- **Fixed scroll not updating TextEditingController**: Scrolling a column now updates the date immediately (same behavior as tapping). Previously, only tapping would trigger the update.
- **Fixed cascading callback issues**: Eliminated race conditions caused by `jumpToItem` triggering unintended `onSelectedItemChanged` callbacks in other columns.

### ♻️ Refactored

- **Complete rewrite of `ScrollDatePicker` internal logic**: Replaced complex `NotificationListener` + `_activeColumn` tracking with a simpler and more reliable approach using `onSelectedItemChanged` directly with a single `_silent` flag.
- **Simplified `DateScrollView`**: Made `onChanged` callback optional for better flexibility.
- **Removed `didUpdateWidget` dependency**: The widget now fully owns its internal date state, preventing the parent from accidentally resetting the selected date.

## 0.0.8

- Adds `minimumDate` property to set the minimum selectable date
- Adds `maximumDate` property to set the maximum selectable date
- Sets `Locale('es', 'ES')` as default locale

## 0.0.1

- Initial release
