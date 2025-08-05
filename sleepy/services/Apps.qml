pragma Singleton

import Quickshell
import QtQuick

import "root:/cfg"

Singleton {
    id: root;

    readonly property list<DesktopEntry> entries: DesktopEntries.applications.values
        .filter(app => !app.noDisplay)
        .sort((a, b) => a.name.localeCompare(b.name));

    function run(app: DesktopEntry) {
        if(!app.runInTerminal) {
            app.execute();
        } else {
            Quickshell.execDetached([
                Defaults.terminal,
                // alacritty needs the -e flag to run a command
                Defaults.terminal == "alacritty" ? "-e" : "",
                app.execString
            ]);
        }
    }

    function query(search: string): list<DesktopEntry> {
        return entries.filter(app => app.name.toLocaleLowerCase().includes(search.toLocaleLowerCase()));
    }
}
