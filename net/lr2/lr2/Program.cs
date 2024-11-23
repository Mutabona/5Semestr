// See https://aka.ms/new-console-template for more information

using System.Text;
using System.Text.RegularExpressions;

internal class Program
{
    public static void Main(string[] args)
    {
        StringBuilder sb = new StringBuilder();
        foreach (string line in File.ReadLines("..\\..\\..\\input.txt"))
        {
            sb.AppendLine(line);
        }
        
        Console.WriteLine("Входные данные:");
        Console.WriteLine(sb.ToString());
        
        var newtext = Regex.Replace(sb.ToString(), "\\d+\\.\\d+", ReplaceCost);
        Console.WriteLine("Выходные данные:");
        Console.WriteLine(newtext);
    }

    private static string ReplaceCost(Match match)
    {
        var numbers = match.Value.Split('.');
        StringBuilder sb = new StringBuilder(numbers[0]);
        sb.Append(" руб. ");
        sb.Append(numbers[1]);
        sb.Append(" коп.");
        return sb.ToString();
    }
}