using lr4;

var p1 = new Person("Sasha");
var r1 = new Resident("Dima");
r1.SetRoom(1);
var r2 = new Resident("Grisha");
r2.SetRoom(2);
r1.ResetRoom();
r2.ResetRoom();

Console.WriteLine($"Is Person Identifieble: {p1 is IIdentifieble}, is Nameble: {p1 is INameble}, is Resident: {p1 is IResident}");
Console.WriteLine($"Is Resident Identifieble: {r1 is IIdentifieble}, is Nameble: {r1 is INameble}, is Person: {r1 is Person}");
