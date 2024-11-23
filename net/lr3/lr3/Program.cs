using lr3;

var p1 = new Person();
var p2 = new Person();

p1.Age = 20;
p1.Name = "Genadiy";
Console.WriteLine("First person with valid data");
p1.PrintPersonInfo();

Console.WriteLine("Second person with invalid age");
p2.Name = "Dmitriy";
try
{
    p1.Age = 17;
}
catch (Exception e) {
    Console.WriteLine(e.Message);
}