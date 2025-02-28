import { Gtk, astalify, ConstructProps } from 'astal/gtk3';
import { GObject } from 'astal';

// taken from https://github.com/Jas-SinghFSU/HyprPanel/blob/master/src/components/shared/Calendar.tsx
// didnt know i could just yoink the widgets from gtk nice
export class Calendar extends astalify(Gtk.Calendar) {
    static {
        GObject.registerClass(this);
    }

    constructor(props: ConstructProps<Calendar, Gtk.Calendar.ConstructorProps>) {
        super(props as any);
    }
}

export class LevelBar extends astalify(Gtk.LevelBar) {
    static {
        GObject.registerClass(this);
    }

    constructor(props: ConstructProps<LevelBar, Gtk.LevelBar.ConstructorProps>) {
        super(props as any);
    }
}
