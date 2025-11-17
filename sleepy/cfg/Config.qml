pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root;

    property StyleCfg style: stylecfg;
    property ModuleCfg modules: modulescfg;
    property BarCfg bar: barcfg;
    property TimingCfg timing: timecfg;
    property ChooserCfg chooser: choosercfg;
    property AppLauncherCfg applauncher: applaunchercfg;
    property NotifsCfg notifs: notifscfg;

    FileView {
        path: Paths.configFile;
        blockLoading: true;
        watchChanges: true;
        onFileChanged: reload();

        JsonAdapter {
            property StyleCfg style: StyleCfg { id: stylecfg; }
            property ModuleCfg modules: ModuleCfg { id: modulescfg; }
            property BarCfg bar: BarCfg { id: barcfg; }
            property TimingCfg timing: TimingCfg { id: timecfg; }
            property ChooserCfg chooser: ChooserCfg { id: choosercfg; }
            property AppLauncherCfg applauncher: AppLauncherCfg { id: applaunchercfg; }
            property NotifsCfg notifs: NotifsCfg { id: notifscfg; }
        }
    }
}
