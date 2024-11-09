using lr1;

var multiplesCalculator = new MultiplesCalculator();

var multiples = multiplesCalculator.CalculateBetween(200, 300, new int[]{12, 16});
Console.Write("Min and max multiples: ");
Console.Write(multiples.First().ToString() + " ");
Console.WriteLine(multiples.Last().ToString());

Console.WriteLine("Print text");
var text = Console.ReadLine();
var characherAmount = text.CharacterCount();

Console.WriteLine($"Character amount: {characherAmount.ToString()}");
text.PrintBackwards();