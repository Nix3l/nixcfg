import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind } from "astal"

import { WeekDay, TaskStatus, TaskItem, schedule } from "./schedule"

let time = Variable(0).poll(1000, () => {
    let date = new Date();
    return date.getHours() + date.getMinutes() / 60.0;
});

let day = Variable(0).poll(1000, () => {
    return new Date().getDay();
});

let task = Variable(TaskItem.NONE).poll(1000, () => CurrentTask());

function CurrentTask(): TaskItem {
    let tasks = schedule.get_day_schedule(day.get());
    for(let task of tasks) {
        if(task.status(time.get(), schedule.ramadan) == TaskStatus.Finished) continue;
        return task;
    }

    return TaskItem.NONE;
}

function human_readable_time(t: number): string {
    let hours = Math.floor(t);
    let minutes = Math.floor((t - hours) * 60);
    return hours == 0 ?
        minutes + "m" :
        hours + "h " + minutes + "m";
}

function TaskInfo(): JSX.Element {
    return <box
        hexpand
        vertical
        spacing={12}
        className="Task"
    >
        <box
            hexpand
            halign={Gtk.Align.CENTER}
            spacing={12}
            className="Info"
        >
            <label
                label={bind(task).as(task => task.name)}
                halign={Gtk.Align.START}
                className="Name"
            />
            <label
                label={bind(task).as(task => "(" + task.detail + ")")}
                halign={Gtk.Align.START}
                className="Detail"
            />
        </box>
        <box
            hexpand
            halign={Gtk.Align.CENTER}
            spacing={12}
            className="Time"
        >
            <label label={
                bind(time).as(time =>
                    task.get().status(time, schedule.ramadan) == TaskStatus.InProgress ?
                    "ends in" :
                    "starts in"
                )
            } />
            <label label={
                bind(time).as((time) => {
                    const curr: TaskItem = task.get();
                    return curr.status(time, schedule.ramadan) == TaskStatus.InProgress ?
                        human_readable_time(
                            (schedule.ramadan ? curr.ramadan_end_time : curr.end_time) - time
                        ):
                        human_readable_time(
                            (schedule.ramadan ? curr.ramadan_start_time : curr.start_time) - time
                        )
                })
            } />
        </box>
    </box>
}

export function TaskTrackerModule(): JSX.Element {
    return <box
        hexpand
        className="TaskTrackerModule"
    > {
        bind(task).as(task => task == TaskItem.NONE ?
            (<centerbox hexpand> <label label="No Available Tasks" /> </centerbox>) :
            (<TaskInfo />)
        )
    } </box>
}
