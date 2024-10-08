namespace Zadanie;

public class MatrixCounter
{
    public Dictionary<int, int> CountNegativeNumbersInRowsWithZeros(List<List<int>> data)
    {
        var result = new Dictionary<int, int>();
        for (int i = 0; i < data.Count; i++)
        {
            if (data[i].Contains(0))
            {
                var amount = data[i].Count(x => x < 0);
                result.Add(i, amount);
            }
        }

        return result;
    }
}