const yaml = require('js-yaml');

class Namepace {
    constructor(total, containers, initContainers, sidecars) {
        this.total = total;
        this.containers = containers;
        this.initContainers = initContainers;
        this.sidecars = sidecars;
    }
}

class limit {
    constructor(cpu, men){
        this.cpu = cpu;
        this.men = men;
    }
}

class request {
    constructor(cpu, men){
        this.cpu = cpu;
        this.men = men;
    }
}

class Resource {
    constructor(limit, request){
        this.limit = limit;
        this.request = request;
    }
}


function run(){

    const total = new Resource(new limit(4,3072), new request(2,2048));
    const containers = new Resource( new limit(2,2048), new request(1,1024));
    const initContainers = new Resource( new limit(2,2048), new request(1,1024));
    const sidecars = new Resource( new limit(0.30,1024), new request(0.25,512));

    const namepace = new Namepace(total, containers, initContainers, sidecars);

    console.log(namepace)
    console.log(namepace.initContainers.limit.cpu)
    console.log(namepace.initContainers.limit.men)
}

run();


/*
namespace1:
    total:
      limit:
        cpu: 4
        mem: 3072
      request:
        cpu: 2
        mem: 2048
    containers:
      limit:
        cpu: 2
        mem: 2048
      request:
        cpu: 1
        mem: 1024
    initContainers:
      limit:
        cpu: 2
        mem: 2048
      request:
        cpu: 1
        mem: 1024
    sidecars:
      limit:
        cpu: 0.30
        mem: 1024
      request:
        cpu: 0.25
        mem: 512


*/
