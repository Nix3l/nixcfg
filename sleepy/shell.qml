//@ pragma UseQApplication
//@ pragma Env QT_SCALE_FACTOR=1

import Quickshell
import QtQuick

import "./cfg"
import "./modules/bar"
import "./modules/applauncher"
import "./modules/notifosd"

ShellRoot {
    Shortcuts {}
    Bar {}
    AppLauncher {}
    NotificationsOSD {}
}
