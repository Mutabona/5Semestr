using Serilog;
using Shouldly;
using Zadanie;

namespace ZadanieTests;

public class StringExtensionTests
{
    private readonly ILogger _logger;
    private static readonly string LogFilePath = "/home/mutabona/repos/5Semestr/tpo/lr1/lr1/ZadanieTests/StringExtensionsTestsLogs/log.log";

    public StringExtensionTests()
    {
        Log.Logger = new LoggerConfiguration()
            .WriteTo.Console()
            .WriteTo.File(LogFilePath, rollingInterval: RollingInterval.Day)
            .CreateLogger();

        _logger = Log.Logger;
    }

    [Fact]
    public void StringExtensionsTest1()
    {
        var source = "a";
        var expectedResult = "";
        
        var result = source.GetStringBetweenColons();
        
        result.ShouldBeEmpty();
        
        var logMessage = $"StringExtensionsTest1 - Source: {source}, Expected result : {expectedResult}, Result: {result}";
        _logger.Information(logMessage);
    }

    [Fact]
    public void StringExtensionsTest2()
    {
        var source = ":";
        var expectedResult = "";
        
        var result = source.GetStringBetweenColons();
        
        result.ShouldBeEmpty();
        
        var logMessage = $"StringExtensionsTest2 - Source: {source}, Expected result : {expectedResult}, Result: {result}";
        _logger.Information(logMessage);
    }

    [Fact]
    public void StringExtensionsTest3()
    {
        var source = "abcde";
        var expectedResult = "";
        
        var result = source.GetStringBetweenColons();
        
        result.ShouldBeEmpty();
        
        var logMessage = $"StringExtensionsTest3 - Source: {source}, Expected result : {expectedResult}, Result: {result}";
        _logger.Information(logMessage);
    }
    
    [Fact]
    public void StringExtensionsTest4()
    {
        var source = ":kukaracha";
        var expectedResult = "kukaracha";
        
        var result = source.GetStringBetweenColons();
        
        result.ShouldBeEquivalentTo(expectedResult);
        
        var logMessage = $"StringExtensionsTest4 - Source: {source}, Expected result : {expectedResult}, Result: {result}";
        _logger.Information(logMessage);
    }
    
    [Fact]
    public void StringExtensionsTest5()
    {
        var source = ":kukaracha:";
        var expectedResult = "kukaracha";
        
        var result = source.GetStringBetweenColons();
        
        result.ShouldBeEquivalentTo(expectedResult);
        
        var logMessage = $"StringExtensionsTest5 - Source: {source}, Expected result : {expectedResult}, Result: {result}";
        _logger.Information(logMessage);
    }
    
    [Fact]
    public void StringExtensionsTest6()
    {
        var source = ":kukaracha:azaza:";
        var expectedResult = "kukaracha";
        
        var result = source.GetStringBetweenColons();
        
        result.ShouldBeEquivalentTo(expectedResult);
        
        var logMessage = $"StringExtensionsTest6 - Source: {source}, Expected result : {expectedResult}, Result: {result}";
        _logger.Information(logMessage);
    }
}