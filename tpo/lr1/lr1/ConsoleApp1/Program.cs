using Zadanie;

var fileNames = new List<string>() {
    "C:\\Users\\k_dod\\repos\\5Semestr\\tpo\\lr1\\lr1\\ConsoleApp1\\testFile.txt",
    "C:\\Users\\k_dod\\repos\\5Semestr\\tpo\\lr1\\lr1\\ConsoleApp1\\testFile1.txt",
    "C:\\Users\\k_dod\\repos\\5Semestr\\tpo\\lr1\\lr1\\ConsoleApp1\\testFile2.txt",
    "C:\\Users\\k_dod\\repos\\5Semestr\\tpo\\lr1\\lr1\\ConsoleApp1\\testFile3.txt",
    "C:\\Users\\k_dod\\repos\\5Semestr\\tpo\\lr1\\lr1\\ConsoleApp1\\testFile4.txt",
    "C:\\Users\\k_dod\\repos\\5Semestr\\tpo\\lr1\\lr1\\ConsoleApp1\\testFile5.txt",
        };

var reader = new SadFileReader();

foreach(var fileName in fileNames) {
        Console.WriteLine($"Test for: {fileName}");
        reader.WriteToConsoleStringWithMaxPunctuactionMarksCount(fileName);
        Console.WriteLine();
    }
