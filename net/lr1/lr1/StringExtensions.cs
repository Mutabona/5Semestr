namespace lr1;

public static class StringExtensions
{
    public static int CharacterCount(this string str) => str.Count(Char.IsLetter);

    public static void PrintBackwards(this string str)
    {
        var words = str.Split(" ");
        foreach (var word in words.Reverse())
        {
            Console.Write(word + " ");
        }
    }
}