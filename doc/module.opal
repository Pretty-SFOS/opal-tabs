#
# Opal module metadata
#
# Lines not starting with a known keyword (i.e. 'name: ') will be ignored.
# One line per value.
#
# SPDX-FileCopyrightText: 2021-2024 Mirian Margiani
# SPDX-License-Identifier: CC0-1.0
#
# @@@ keep this line: based on template v1.0.0
#

# current semantic version number, cf. https://semver.org
version: 2.0.0

# plain name as used in the module repository URL, will be prefixed with "opal-"
# where necessary
name: tabs

# styled name including capitalisation etc., will be prefixed with "Opal."
# where necessary
nameStyled: Tabs

# very short description of this module: must be plain text without formatting
# and should be as short as possible. This text may be used as the description
# of a Git repository, and is used in documentation.
briefDescription: QML module for adding tab bars to Sailfish apps

# description of this module: may use rich text and will be translated in
# Opal Gallery. Line breaks can included with '\n' but should be avoided.
description: This module provides an easy way to add tab bars to apps.

# attribution string for the whole module, in the same form as a SPDX
# FileCopyrightText entry.
attribution: 2024 Mirian Margiani:2013-2020 Jolla Ltd:2020 Open Mobile Platform LLC

# colon-separated list of this module's current maintainer(s)
maintainers: Mirian Margiani

# colon-separated list of this module's author(s) and contributors
# this list should be exhaustive
authors: Mirian Margiani

# the module's SPDX license id, cf. https://spdx.org/licenses/
mainLicenseSpdx: GPL-3.0-or-later

# The main example page to be used in Opal Gallery is doc/gallery.qml.
# Additional pages must be placed in a directory called "doc/gallery" and listed
# in "extraGalleryPages". Set to "none" if only the main QML file is used.
# The field contains a space separated list of file names without path. Names
# must not contain spaces. Use "import 'gallery'" to use these extra components.
# Use "EmptyDummyPage.qml" as placeholder in examples (provided by Opal Gallery).
#
# Example:
# extraGalleryPages: none
extraGalleryPages: DummyTab.qml OptionsTab.qml

# colon-separated list of other Opal modules that this module depends on
# Use the unstyled name without "opal-" prefix, as in the "name:" metadata field,
# or set this field to "none" if there are no dependencies.
dependencies: none

# where the module's sources are located
# This url will be automatically generated from the default repository url and
# this module's name as specified above.
# sourcesUrl: https://github.com/Pretty-SFOS/opal-<name>
