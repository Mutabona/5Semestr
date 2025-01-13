using lr6;

EventBus eventBus = new EventBus();

var distributor = new Distributor(eventBus);
var worker = new Worker(eventBus);

distributor.Distribute("Pivo");