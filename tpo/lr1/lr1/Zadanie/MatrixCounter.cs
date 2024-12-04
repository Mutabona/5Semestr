namespace Zadanie;

public class MatrixCounter
{
    private MatrixCounter() {}
    
    public int CountNegativeNumbersInRowsWithZeros(List<List<int>> data)
    {
        int result = 0;
        foreach (var row in data)
        {
            if (row.Contains(0))
            {
                var amount = row.Count(x => x < 0);
                result += amount;
            }
        }

        return result;
    }

    public class MatrixCounterBuilder()
    {
        public MatrixCounter Build()
        {
            return new MatrixCounter();
        }
    }
}