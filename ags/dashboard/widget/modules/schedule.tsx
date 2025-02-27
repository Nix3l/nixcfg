export enum WeekDay {
    Sunday = 0,
    Monday = 1,
    Tuesday = 2,
    Wednesday = 3,
    Thursday = 4,
    Friday = 5,
    Saturday = 6
}

export enum TaskStatus {
    Pending = 0,
    InProgress = 1,
    Finished = 2,
}

export class TaskItem {
    public static NONE: TaskItem = new TaskItem("", "", 0, 0);

    public name: string;
    public detail: string;
    public start_time: number;
    public end_time: number;

    constructor(name: string, detail: string, start_time: number, end_time: number) {
        this.detail = detail;
        this.name = name;
        this.start_time = start_time;
        this.end_time = end_time;
    }

    public status(time: number): TaskStatus {
        if(time < this.start_time) return TaskStatus.Pending;
        else if(time < this.end_time) return TaskStatus.InProgress;
        else return TaskStatus.Finished;
    }

    public get_duration(): number {
        return this.end_time - this.start_time;
    }
}

export class Schedule {
    public items: TaskItem[][];

    constructor() {
        this.items = [[], [], [], [], [], [], []];
    }

    public get_day_schedule(day: WeekDay) {
        return this.items[day];
    }

    public add_item(item: TaskItem, day: WeekDay) {
        this.items[day].push(item);
    }
}

function time(hours: number, minutes: number): number {
    return hours + minutes / 60.0;
}

// SCHEDULE
const math: TaskItem = new TaskItem(
    "Discrete Math",
    "W-202",
    time(9, 30),
    time(11, 0)
);

const programming: TaskItem = new TaskItem(
    "Programming",
    "S-210",
    time(11, 30),
    time(14, 10)
);

const security: TaskItem = new TaskItem(
    "Security",
    "S-214",
    time(14, 10),
    time(15, 20)
);

const pom: TaskItem = new TaskItem(
    "Principles",
    "W-109",
    time(9, 30),
    time(10, 40)
);

const english1: TaskItem = new TaskItem(
    "English",
    "W-108",
    time(13, 0),
    time(13, 50)
);

const english2: TaskItem = new TaskItem(
    "English",
    "W-108",
    time(13, 0),
    time(14, 10)
);

export const schedule: Schedule = new Schedule();

schedule.add_item(math, WeekDay.Sunday);
schedule.add_item(programming, WeekDay.Sunday);
schedule.add_item(security, WeekDay.Sunday);

schedule.add_item(pom, WeekDay.Monday);
schedule.add_item(english2, WeekDay.Monday);

schedule.add_item(math, WeekDay.Wednesday);
schedule.add_item(english1, WeekDay.Wednesday);
schedule.add_item(security, WeekDay.Wednesday);

schedule.add_item(pom, WeekDay.Thursday);
