const yaml = require('js-yaml');
const fs   = require('fs')


class namespace {
    constructor(total, containers, initContainers, sidecars) {
        this.total = total;
        this.containers = containers;
        this.initContainers = initContainers;
        this.sidecars = sidecars;
    }
}

class limit {
    constructor(ob){
        this.cpu = ob.cpu;
        this.mem = ob.mem;
    }
}

class request {
   constructor(ob){
        this.cpu = ob.cpu;
        this.mem = ob.mem;
    }
}

class resource {
    constructor(limit, request){
        this.limit = limit;
        this.request = request;
    }
}





function run(){
/*
    const total = new Resource(new limit(4,3072), new request(2,2048));
    const containers = new Resource( new limit(2,2048), new request(1,1024));
    const initContainers = new Resource( new limit(2,2048), new request(1,1024));
    const sidecars = new Resource( new limit(0.30,1024), new request(0.25,512));

    const namespace = new Namepace(total, containers, initContainers, sidecars);

    console.log(namespace);
    console.log(namespace.initContainers.limit.cpu);
    console.log(namespace.initContainers.limit.men);
*/


    try {
      const doc = yaml.load(fs.readFileSync('limits.yaml', 'utf8'));
      console.log(doc.total);
      console.log(Object.keys(doc));
      console.log(doc.namespace.namespace1);
  
      const total = new resource(new limit(doc.namespace.namespace1.total.limit), new request(doc.namespace.namespace1.total.request));
      const containers = new resource(new limit(doc.namespace.namespace1.containers.limit), new request(doc.namespace.namespace1.containers.request));
      const initContainers = new resource(new limit(doc.namespace.namespace1.initContainers.limit), new request(doc.namespace.namespace1.initContainers.request));
      const sidecars = new resource( new limit(doc.namespace.namespace1.sidecars.limit), new request(doc.namespace.namespace1.sidecars.request));
  
      const dsfsdf = new namespace(total, containers, initContainers, sidecars);
  
      console.log(dsfsdf);
      console.log(dsfsdf.initContainers.limit.cpu);
      console.log(dsfsdf.initContainers.limit.men);



      
    } catch (e) {
      console.log(e);
    }
    
    

}

run();


// https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
// https://stackabuse.com/reading-and-writing-yaml-to-a-file-in-node-js-javascript/
//

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
