namespace lr1;

public class MultiplesCalculator
{
    public ICollection<int> CalculateBetween(int min, int max, int[] dividers)
    {
        var result = new List<int>();
        for (int i = min; i <= max; i++)
        {
            if (dividers.All(d => i % d == 0))
            {
                result.Add(i);
            }
        }
        return result;
    }
}