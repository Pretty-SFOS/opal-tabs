//@ This file is part of Opal.TabBar.
//@ SPDX-FileCopyrightText: 2024 Mirian Margiani
//@ SPDX-FileCopyrightText: Copyright (C) 2019 Jolla Ltd.
//@ SPDX-FileCopyrightText: Copyright (C) 2020 Open Mobile Platform LLC.
//@ SPDX-License-Identifier: GPL-3.0-or-later
//@
//@ /****************************************************************************************
//@ **
//@ ** Copyright (C) 2019 Jolla Ltd.
//@ ** Copyright (C) 2020 Open Mobile Platform LLC.
//@ ** All rights reserved.
//@ **
//@ ** This file is part of Sailfish Silica UI component package.
//@ **
//@ ** You may use this file under the terms of BSD license as follows:
//@ **
//@ ** Redistribution and use in source and binary forms, with or without
//@ ** modification, are permitted provided that the following conditions are met:
//@ **     * Redistributions of source code must retain the above copyright
//@ **       notice, this list of conditions and the following disclaimer.
//@ **     * Redistributions in binary form must reproduce the above copyright
//@ **       notice, this list of conditions and the following disclaimer in the
//@ **       documentation and/or other materials provided with the distribution.
//@ **     * Neither the name of the Jolla Ltd nor the
//@ **       names of its contributors may be used to endorse or promote products
//@ **       derived from this software without specific prior written permission.
//@ **
//@ ** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//@ ** ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//@ ** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//@ ** DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
//@ ** ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//@ ** (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//@ ** LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//@ ** ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//@ ** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//@ ** SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//@ **
//@ ****************************************************************************************/

import QtQuick 2.4
import Sailfish.Silica 1.0
import Sailfish.Silica.private 1.0
import "private/Util.js" as Util
import "private"

PagedView {
    id: root

    default property alias items: itemContainer.data
    model: items

    property Component header
    property Component footer
    property bool hasFooter: footer
    property alias tabBarItem: tabBarLoader.item
    property real tabBarHeight: tabBarItem ? tabBarItem.height : 0

    property string sourceProperty: "modelData"

    property real yOffset: currentItem && currentItem._yOffset || 0
    property bool _headerBackgroundVisible: true

    property Item _page: Util.findPage(root)

    property int __silica_tab_view

    header: TabBar {
        model: root.model
    }

    verticalAlignment: hasFooter ? PagedView.AlignTop : PagedView.AlignBottom
    cacheSize: 0

    contentItem {
        y: root.hasFooter ? 0 : tabBarLoader.height
        height: root.height - tabBarLoader.height
    }

    Item {
        id: itemContainer
        width: 0
        height: 0

        property Item _ctxPage: _page
        property Item _ctxTabContainer: root
        property int _ctxTopMargin: tabBarHeight
    }

    Loader {
        id: tabBarLoader

        sourceComponent: root.hasFooter ? root.footer : root.header
        width: parent.width
        z: root.yOffset < 0 && !root.hasFooter ? -1 : 1
        y: root.hasFooter ? root.height - tabBarLoader.height : Math.max(0, -root.yOffset)

        Item {
            id: backgroundRectangleContainer
            property Item item

            anchors {
                fill: parent
                topMargin: (root.yOffset > Theme.paddingSmall) || root.hasFooter
                    ? 0 : Theme.paddingSmall
                rightMargin: Theme.paddingSmall
            }
        }
    }

    delegate: Loader {
        // tab container
        id: tabLoader

        // properties are passed on to the TabItem that is being loaded
        property Item _ctxTabContainer: tabLoader
        property int _ctxTopMargin: tabBarHeight
        property Item _ctxPage: root._page
        readonly property bool isCurrentItem: PagedView.isCurrentItem
        readonly property real _yOffset: item && item._yOffset || 0

        property bool loading: Qt.application.active && isCurrentItem && status === /*Animated*/Loader.Loading

//        sourceComponent: model[root.sourceProperty]
        sourceComponent: model.modelData.body
        asynchronous: true

        width: item ? item.implicitWidth : root.contentItem.width
        height: item ? item.implicitHeight : root.contentItem.height

        onItemChanged: {
            if (!item) return
            tabFadeAnimation.target = null
            item.focus = true
            item.opacity = 0
            tabFadeAnimation.target = item
            tabFadeAnimation.from = 0
            tabFadeAnimation.to = 1
            tabFadeAnimation.restart()
        }

        FadeAnimation {
            id: tabFadeAnimation
            running: false
        }

        BusyIndicator {
            running: !delayBusy.running && loading

            // Avoid flicker when tab container gets repositioned
            parent: tabLoader.parent
            x: (tabLoader.width - width) / 2 + tabLoader.x
            y: root.height/3 - height/2 - tabBarLoader.height
            size: BusyIndicatorSize.Large

            Timer {
                id: delayBusy
                interval: 800
                running: tabLoader.loading
            }
        }
    }

    Component.onCompleted: {
        // Avoid hard dependency on private Silica components
        backgroundRectangleContainer.item = Qt.createQmlObject("\
            import QtQuick 2.6
            import %1 1.0

            BackgroundRectangle {
                id: backgroundRectangle
                visible: _headerBackgroundVisible
                anchors.fill: parent
                color: __silica_applicationwindow_instance._backgroundColor
            }
        ".arg('Sailfish.Silica.private'),
            backgroundRectangleContainer,
            'BackgroundRectangle'
        )
    }
}
