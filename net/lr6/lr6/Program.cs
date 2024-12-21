using lr6;

var footballers = new List<Footballer>
{
    new()
    {
        Name = "Genadiy",
        Goals = 10
    },
    new()
    {
        Name = "Vladimir",
        Goals = 9
    },
    new()
    {
        Name = "Svetlana",
        Goals = 8
    },
    new()
    {
        Name = "Zinoida",
        Goals = 0
    },
    new()
    {
        Name = "Andrey",
        Goals = 0
    },
    new()
    {
        Name = "Lexa",
        Goals = 0
    },
};

var bests = footballers
    .OrderByDescending(x => x.Goals)
    .Take(3)
    .ToList();
    
var worsts = 
    from footballer in footballers
    where footballer.Goals == 0
    orderby footballer.Goals
    select footballer;
    
Console.WriteLine("Bests: ");
foreach (var best in bests)
{
    Console.WriteLine($"{best.Name}, {best.Goals}");
}
Console.WriteLine("Worsts: ");
foreach (var worst in worsts)
{
    Console.WriteLine($"{worst.Name}, {worst.Goals}");
}