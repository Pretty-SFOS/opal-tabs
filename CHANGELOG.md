<!--
SPDX-FileCopyrightText: 2023-2025 Mirian Margiani
SPDX-License-Identifier: GFDL-1.3-or-later
-->

# Changelog

## 2.1.1 (2025-12-23)

- Fixed packaging to actually include `opal.pri` and `.gitignore` files for
  easier integration into apps. Add `include(libs/opal.pri)`
  to your `harbour-myapp.pro` file to enable Opal in your app.
- **Note:** you *still* must modify your `yaml` or `spec` file for Harbour compliance!
  See [here](https://github.com/Pretty-SFOS/opal/blob/main/README.md#using-opal)
  for updated instructions.
- Fixed documentation to exclude some unnecessary generated parts.

## 2.1.0 (2025-12-22)

- Updated packaging to make it easier to integrate this module in apps
- Added support for specifying tab source as a URL instead of a `Component`.
  This is useful if a custom model (like `ListModel`) is used instead of `itemContainer.data`,
  for example, if tabs are added dynamically, like here: `<listModel>.append({..., source: Qt.resolvedUrl(...)})`
- Added proper support for using a QML `ListModel` or another `QAbstractListModel`-based model instead of an array as tab container
- Fixed sizing behavior to fall back to screen size if page size is undefined
- Fixed finding the main flickable if it is not defined manually
- Fixed caching tabs pages
- Documented use of private Silica properties (to prevent them becoming a problem in the future)

Thank you to roundedrectangle for most of these changes!

## 2.0.0 (2024-10-30)

- First public release of the mostly stable module including a new, simplified API, and many fixes all around

## 1.0.0 (2024-10-22)

- First version based on the BSD-3-Clause licensed original files from Silica
