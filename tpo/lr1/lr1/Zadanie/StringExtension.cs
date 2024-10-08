using System.Text.RegularExpressions;

namespace Zadanie;

public static class StringExtension
{
    public static string GetStringBetweenColons(this string str)
    {
        var match = Regex.Match(str, ":[^:]*:?");
        var result = match.Groups[0].Value.Replace(":", "");
        return result;
    }
}