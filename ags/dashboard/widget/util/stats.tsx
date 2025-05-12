import { Variable, exec } from 'astal';

// yes i know awk exists
// no i will not learn it
const max_ram = 16 * 1024 * 1024;
let mem_usage = Variable(0).poll(1000, () => {
    return Number(exec("free -L").split(" ").filter((s) => s !== "")[5]);
});

let mem_usage_abbr = Variable("").poll(1000, () => {
    return exec("free -Lh").split(" ").filter((s) => s !== "")[5];
});

let cpu_usage = Variable(0).poll(1000, () => {
    return 0;
    return (100 - Number(exec(`bash -c 'top -b -n1 -i | grep \"id, \"'`).split(" ").filter((s) => s !== "")[7])) / 100;
});

export { mem_usage, mem_usage_abbr, max_ram, cpu_usage }
