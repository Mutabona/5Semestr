using Zadanie;
using Shouldly;

namespace ZadanieTests;

public class StringExtensionTests
{
    [Fact]
    public void StringExtensionsTest5()
    {
        var source = ":kukaracha:";
        
        var result = source.GetStringBetweenColons();
        
        result.ShouldBeEquivalentTo("kukaracha");
    }
    
    [Fact]
    public void StringExtensionsTest6()
    {
        var source = ":kukaracha:azaza:";
        
        var result = source.GetStringBetweenColons();
        
        result.ShouldBeEquivalentTo("kukaracha");
    }
    
    [Fact]
    public void StringExtensionsTest4()
    {
        var source = ":kukaracha";
        
        var result = source.GetStringBetweenColons();
        
        result.ShouldBeEquivalentTo("kukaracha");
    }
    
    [Fact]
    public void StringExtensionsTest3()
    {
        var source = "abcde";
        
        var result = source.GetStringBetweenColons();
        
        result.ShouldBeEmpty();
    }
    
    [Fact]
    public void StringExtensionsTest2()
    {
        var source = ":";
        
        var result = source.GetStringBetweenColons();
        
        result.ShouldBeEmpty();
    }
    
    [Fact]
    public void StringExtensionsTest1()
    {
        var source = "a";
        
        var result = source.GetStringBetweenColons();
        
        result.ShouldBeEmpty();
    }
}