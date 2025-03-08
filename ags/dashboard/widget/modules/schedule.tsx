import { FixTimeDigits } from "../util/utils"

export enum WeekDay {
    Sunday = 0,
    Monday = 1,
    Tuesday = 2,
    Wednesday = 3,
    Thursday = 4,
    Friday = 5,
    Saturday = 6,
}

// TODO: these names are awful
export enum TaskDuration {
    Hour = 0,
    HourHalf = 1,
    TwoHour = 2,
    ThreeHour = 3,
}

export enum TaskStatus {
    Pending = 0,
    InProgress = 1,
    Finished = 2,
}

function time(hours: number, minutes: number): number {
    return hours + minutes / 60.0;
}

function task_duration(duration: TaskDuration, ramadan: boolean): number {
    if(duration == TaskDuration.Hour)
        return ramadan ? time(0, 50) : time(1, 0); 
    if(duration == TaskDuration.HourHalf)
        return ramadan ? time(1, 10) : time(1, 30);
    if(duration == TaskDuration.TwoHour)
        return ramadan ? time(1, 30) : time(2, 0);
    if(duration == TaskDuration.ThreeHour)
        return ramadan ? time(2, 20) : time(3, 0);

    return 1;
}

export class TaskItem {
    public static NONE: TaskItem = new TaskItem("", "", 0, 0, [0], false);

    public name: string;
    public detail: string;
    public duration: TaskDuration;
    public start_time: number;
    public end_time: number;
    public ramadan_start_time: number;
    public ramadan_end_time: number;
    public days: WeekDay[];

    constructor(name: string, detail: string, start_time: number, duration: TaskDuration, days: WeekDay[], ramadan_timing: boolean) {
        this.name = name;
        this.detail = detail;
        this.duration = duration;

        this.start_time = start_time;
        this.end_time = start_time + task_duration(this.duration, false);
        if(ramadan_timing) {
            let index = (start_time - 8.5) / task_duration(this.duration, false);
            this.ramadan_start_time = 9.5 + index * task_duration(this.duration, true);
            this.ramadan_end_time = this.ramadan_start_time + task_duration(this.duration, true);
        } else {
            this.ramadan_start_time = this.start_time;
            this.ramadan_end_time = this.end_time;
        }

        this.days = days;
    }

    public status(time: number, ramadan: boolean): TaskStatus {
        if(time < (ramadan ? this.ramadan_start_time : this.start_time))
            return TaskStatus.Pending;
        else if(time < (ramadan ? this.ramadan_end_time : this.end_time))
            return TaskStatus.InProgress;
        else
            return TaskStatus.Finished;
    }

    public static time_string(time: number) {
        let hour = time >= 13 ? Math.floor(time) - 12 : Math.floor(time);
        let minute = Math.round((time - Math.floor(time)) * 60);
        return FixTimeDigits(hour) + ":" + FixTimeDigits(minute);
    }
}

export class Schedule {
    public daily_tasks: TaskItem[][];
    public ramadan: boolean;

    constructor() {
        this.daily_tasks = [[], [], [], [], [], [], []];
        this.ramadan = true;
    }

    public get_day_schedule(day: WeekDay): TaskItem[] {
        return this.daily_tasks[day];
    }

    public process_tasks(tasks: TaskItem[]) {
        for(let item of tasks) {
            for(let day of item.days)
                this.daily_tasks[day].push(item);
        }

        for(let i = 0; i < this.daily_tasks.length; i ++) {
            this.daily_tasks[i] = this.daily_tasks[i].sort(
                (a, b) => a.start_time - b.start_time
            );
        }
    }
}

// SCHEDULE
export const schedule: Schedule = new Schedule();
schedule.ramadan = true;

schedule.process_tasks([
    new TaskItem(
        "Discrete Math",
        "W-202",
        time(8, 30),
        TaskDuration.TwoHour,
        [ WeekDay.Sunday, WeekDay.Wednesday ],
        true,
    ),
    new TaskItem(
        "Programming",
        "S-210",
        time(11, 30),
        TaskDuration.ThreeHour,
        [ WeekDay.Sunday ],
        true,
    ),
    new TaskItem(
        "Security",
        "S-214",
        time(14, 30),
        TaskDuration.HourHalf,
        [ WeekDay.Sunday, WeekDay.Wednesday ],
        true,
    ),
    new TaskItem(
        "Principles",
        "W-109",
        time(8, 30),
        TaskDuration.HourHalf,
        [ WeekDay.Monday, WeekDay.Thursday ],
        true,
    ),
    new TaskItem(
        "English",
        "W-108",
        time(13, 0),
        TaskDuration.HourHalf,
        [ WeekDay.Monday, WeekDay.Thursday ],
        true,
    ),
    new TaskItem(
        "English",
        "W-108",
        time(13, 0),
        TaskDuration.Hour,
        [ WeekDay.Wednesday ],
        true,
    ),
]);
