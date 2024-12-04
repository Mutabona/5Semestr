using Zadanie;
using Shouldly;

namespace ZadanieTests;

public class MatrixCounterTests
{
    private readonly MatrixCounter _matrix;

    public MatrixCounterTests()
    {
        var builder = new MatrixCounter.MatrixCounterBuilder();
        _matrix = builder.Build();
    }
    
    [Fact]
    public void MatrixTest1()
    {
        var source = new List<List<int>>
        {
            new List<int> { 1 },
        };

        var result = _matrix.CountNegativeNumbersInRowsWithZeros(source);
        
        result.ShouldBeEquivalentTo(0);
    }
    
    [Fact]
    public void MatrixTest2()
    {
        var source = new List<List<int>>
        {
            new List<int> { 1 },
        };

        var result = _matrix.CountNegativeNumbersInRowsWithZeros(source);
        
        result.ShouldBeEquivalentTo(0);
    }
    
    [Fact]
    public void MatrixTest3()
    {
        var source = new List<List<int>>
        {
            new List<int> { 1, 2, 3},
            new List<int> { 4, 5, 6},
            new List<int> { 7, 8, 9},
        };

        var result = _matrix.CountNegativeNumbersInRowsWithZeros(source);
        
        result.ShouldBeEquivalentTo(0);
    }
    
    [Fact]
    public void MatrixTest4()
    {
        var source = new List<List<int>>
        {
            new List<int> { 1, 5, 0, 0},
            new List<int> { 2, 3, 4, 5},
        };

        var result = _matrix.CountNegativeNumbersInRowsWithZeros(source);
        
        result.ShouldBeEquivalentTo(0);
    }
    
    [Fact]
    public void MatrixTest5()
    {
        var source = new List<List<int>>
        {
            new List<int> { 1, 2, 3, 4},
            new List<int> { 0, 0, 0, -1},
            new List<int> { 6, 7, 8, 9},
            new List<int> { 1, 2, 3, 4},
        };

        var result = _matrix.CountNegativeNumbersInRowsWithZeros(source);
        
        result.ShouldBeEquivalentTo(1);
    }
    
    
    [Fact]
    public void MatrixTest6()
    {
        var source = new List<List<int>>
        {
            new List<int> { 1, 2, 0},
            new List<int> { 4, 0, 6},
            new List<int> { 7, 0, 9},
        };

        var result = _matrix.CountNegativeNumbersInRowsWithZeros(source);
        
        result.ShouldBeEquivalentTo(0);
    }
    
    [Fact]
    public void MatrixTest7()
    {
        var source = new List<List<int>>
        {
            new List<int> { 1, 0, 0, -1, 0},
            new List<int> { 2, 3, 4, 5, 6},
            new List<int> { 0, 0, -1, -6, 0},
        };

        var result = _matrix.CountNegativeNumbersInRowsWithZeros(source);
        
        result.ShouldBeEquivalentTo(3);
    }
}