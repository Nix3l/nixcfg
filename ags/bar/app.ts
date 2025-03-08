import { App } from "astal/gtk3"
import { exec } from "astal"

import style from "./style.scss"
import TopBar from "./bar/bar"

App.start({
    css: style,
    instanceName: "bar",
    requestHandler(request, res) {
        print(request);
        res("ok");
    },
    main: () => {
        App.get_monitors().map(TopBar);
    },
})
