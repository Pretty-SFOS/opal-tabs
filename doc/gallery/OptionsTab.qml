//@ This file is part of Opal.Tabs for use in harbour-opal-gallery.
//@ https://github.com/Pretty-SFOS/opal-tabs
//@ SPDX-License-Identifier: GPL-3.0-or-later
//@ SPDX-FileCopyrightText: 2023-2024 Mirian Margiani

import QtQuick 2.0
import Sailfish.Silica 1.0 as S
import Opal.Tabs 1.0 as T

T.TabItem {
    id: root
    flickable: flick

    property Item page

    S.SilicaFlickable {
        id: flick
        anchors.fill: parent
        contentHeight: column.height

        Column {
            id: column
            width: parent.width

            S.PageHeader {
                title: qsTr("Options")
            }

            S.TextSwitch {
                text: qsTr("Show icons")
                automaticCheck: false
                checked: page.enableIcons
                onClicked: page.enableIcons = !page.enableIcons
            }

            S.TextSwitch {
                text: qsTr("Show descriptions")
                automaticCheck: false
                checked: page.enableDescriptions
                onClicked: page.enableDescriptions = !page.enableDescriptions
            }

            S.TextSwitch {
                text: qsTr("Show tab bar")
                automaticCheck: false
                checked: page.tabBarVisible
                onClicked: page.tabBarVisible = !page.tabBarVisible
            }

            S.ComboBox {
                label: qsTr("Tab bar position")
                onCurrentIndexChanged: {
                    page.tabBarPosition = (
                        currentIndex == 0 ? Qt.AlignTop : Qt.AlignBottom)
                }

                menu: S.ContextMenu {
                    S.MenuItem {
                        text: qsTr("Top")
                    }
                    S.MenuItem {
                        text: qsTr("Bottom")
                    }
                }
            }
        }
    }
}
