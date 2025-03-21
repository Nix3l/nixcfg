import { App } from "astal/gtk3"
import style from "./style.scss"
import Dashboard from "./widget/dashboard"

App.start({
    css: style,
    instanceName: "dashboard",
    main() {
        App.get_monitors().map(Dashboard)
    },
})
