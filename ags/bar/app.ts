import { App } from "astal/gtk3"
import style from "./style.scss"
import TopBar from "./top_bar/bar"

App.start({
    css: style,

    instanceName: "js",
    requestHandler(request, res) {
        print(request);
        res("ok");
    },

    main: () => { 
        App.get_monitors().map(TopBar);
    },
})
