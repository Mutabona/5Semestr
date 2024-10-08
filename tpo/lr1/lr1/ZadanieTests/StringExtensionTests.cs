using Zadanie;
using Shouldly;

namespace ZadanieTests;

public class StringExtensionTests
{
    [Fact]
    public void StringExtensions_ManySymbols_Between_TwoColons()
    {
        var source = ":kukaracha:";
        
        var result = source.GetStringBetweenColons();
        
        result.ShouldBeEquivalentTo("kukaracha");
    }
    
    [Fact]
    public void StringExtensions_ManySymbols_Between_ManyColons()
    {
        var source = ":kukaracha:azaza:";
        
        var result = source.GetStringBetweenColons();
        
        result.ShouldBeEquivalentTo("kukaracha");
    }
    
    [Fact]
    public void StringExtensions_ManySymbols_After_OneColon()
    {
        var source = ":kukaracha";
        
        var result = source.GetStringBetweenColons();
        
        result.ShouldBeEquivalentTo("kukaracha");
    }
    
    [Fact]
    public void StringExtensions_ManySymbols_Without_Colons()
    {
        var source = "kukaracha";
        
        var result = source.GetStringBetweenColons();
        
        result.ShouldBeEmpty();
    }
    
    [Fact]
    public void StringExtensions_ManySymbols_Before_Colon()
    {
        var source = "kukaracha:";
        
        var result = source.GetStringBetweenColons();
        
        result.ShouldBeEmpty();
    }
}