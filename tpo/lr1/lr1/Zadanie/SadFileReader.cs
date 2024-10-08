namespace Zadanie;

public class SadFileReader
{
    private readonly List<char> _punctuationMarks = new List<char>(){',', '.', '!', '?', ';', ':'};
    
    public void WriteToConsoleStringWithMaxPunctuactionMarksCount(string fileName)
    {
        var maxStrings = new List<string>();
        int punctuationMarksMaxAmount = 0;
        
        var reader = new StreamReader(fileName);
        string? line;
        while ((line = reader.ReadLine()) != null)
        {
            int punctuationMarksCount = line.Count(x => _punctuationMarks.Contains(x));
            if (punctuationMarksCount > punctuationMarksMaxAmount)
            {
                maxStrings.Clear();
                maxStrings.Add(line);
                punctuationMarksMaxAmount = punctuationMarksCount;
            }
            else if (punctuationMarksCount == punctuationMarksMaxAmount)
            {
                maxStrings.Add(line);
            }
        }

        foreach (var maxString in maxStrings)
        {
            Console.WriteLine(maxString);
        }
    }
}