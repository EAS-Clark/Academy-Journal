const process = require('process');
const os = require('os');
const disk = require('diskusage');

let query = "";
module.exports = function (connection, params, resolve, reject) {


    var usage = process.cpuUsage();
    usage = process.cpuUsage(usage);

    const memoryData = process.memoryUsage();
  
    var ut_sec = os.uptime();
    var ut_min = ut_sec/60;
    var ut_hour = ut_min/60;
       
    ut_sec = Math.floor(ut_sec);
    ut_min = Math.floor(ut_min);
    ut_hour = Math.floor(ut_hour);
      
    ut_hour = ut_hour%60;
    ut_min = ut_min%60;
    ut_sec = ut_sec%60;
      
    let diskFree;
    let diskTotal;

    disk.check('/', function(err, info) {
        diskFree = info.free;
        diskTotal = info.total;
    });


    resolve({"status": "success", "status_message": "sending back image", "discord_message": `**Stats:**
    Rss: ${formatBytes(memoryData.rss)} Total memory allocated for the process execution
    HeapTotal: ${formatBytes(memoryData.heapTotal)}  Total size of the allocated heap
    HeapUsed: ${formatBytes(memoryData.heapUsed)} Actual memory used during the execution
    Total memory: ${formatBytes(os.totalmem())}
    Free memory: ${formatBytes(os.freemem())}
    ----------------------------------------------------
    CPU: ${usage.user} Mhz cpu used during the execution
    CPUS: ${os.cpus().length}
    ----------------------------------------------------
    Disk free ${formatBytes(diskFree)}
    Disk total ${formatBytes(diskTotal)}
    Disk used ${formatBytes(diskTotal - diskFree)}
    ----------------------------------------------------
    Up time: ${ut_hour} Hour(s) ${ut_min} minute(s) and ${ut_sec} second(s)
    `
    });

}

function formatBytes(bytes, decimals = 2) {
    if (bytes === 0) return '0 Bytes';

    const k = 1024;
    const dm = decimals < 0 ? 0 : decimals;
    const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

    const i = Math.floor(Math.log(bytes) / Math.log(k));

    return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
}