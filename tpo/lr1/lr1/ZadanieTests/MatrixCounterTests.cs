using Zadanie;
using Shouldly;

namespace ZadanieTests;

public class MatrixCounterTests
{
    private readonly MatrixCounter _matrix;

    public MatrixCounterTests()
    {
        _matrix = new MatrixCounter();
    }
    
    [Fact]
    public void MatrixTest_ManyElements_ManyZeros_ManyNegativeElements()
    {
        var source = new List<List<int>>
        {
            new List<int> { 0, 1, -1, -5, 3},
            new List<int> { 9, 9, 9, 3, -1},
            new List<int> { 0, 0, -4, 1, 1},
            new List<int> { 9, 9, 9, 0, 6},
            new List<int> { 9, 9, 9, 1, 6},
        };

        var result = _matrix.CountNegativeNumbersInRowsWithZeros(source);
        
        result.ShouldBeEquivalentTo(new Dictionary<int, int>
        {
            {0, 2},
            {2, 1},
            {3, 0}
        });
    }
}