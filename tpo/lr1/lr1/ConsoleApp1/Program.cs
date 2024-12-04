using Zadanie;

var matrix = new MatrixCounter.MatrixCounterBuilder().Build();

var source = new List<List<int>>
{
    new List<int> { 1, 2, 3},
    new List<int> { 4, 5, 6},
    new List<int> { 7, 8, 9},
};

var result = matrix.CountNegativeNumbersInRowsWithZeros(source);

var fileNames = new List<string>() {
    @"C:\Users\k_dod\source\repos\5Semestr\tpo\lr1\lr1\ConsoleApp1\testFile.txt",
    @"C:\Users\k_dod\source\repos\5Semestr\tpo\lr1\lr1\ConsoleApp1\testFile1.txt",
    @"C:\Users\k_dod\source\repos\5Semestr\tpo\lr1\lr1\ConsoleApp1\testFile2.txt",
    @"C:\Users\k_dod\source\repos\5Semestr\tpo\lr1\lr1\ConsoleApp1\testFile3.txt",
    @"C:\Users\k_dod\source\repos\5Semestr\tpo\lr1\lr1\ConsoleApp1\testFile4.txt",
    @"C:\Users\k_dod\source\repos\5Semestr\tpo\lr1\lr1\ConsoleApp1\testFile5.txt",
        };

var reader = new SadFileReader();

foreach(var fileName in fileNames) {
        Console.WriteLine($"Test for: {fileName}");
        reader.WriteToConsoleStringWithMaxPunctuactionMarksCount(fileName);
        Console.WriteLine();
    }
