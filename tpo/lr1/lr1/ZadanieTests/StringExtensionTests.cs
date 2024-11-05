using Serilog;
using Shouldly;
using Zadanie;

namespace ZadanieTests;

public class StringExtensionTests
{
    private readonly ILogger _logger;
    private static readonly string LogFilePath = "/home/mutabona/repos/5Semestr/tpo/lr3/StringExtensionsTestsLogs/log.log";

    public StringExtensionTests()
    {
        Log.Logger = new LoggerConfiguration()
            .WriteTo.Console()
            .WriteTo.File(LogFilePath, rollingInterval: RollingInterval.Day)
            .CreateLogger();

        _logger = Log.Logger;
    }
    
    [Theory]
    [InlineData("a", "")]
    [InlineData(":", "")]
    [InlineData("abcde", "")]
    [InlineData(":kukaracha", "kukaracha")]
    [InlineData(":kukaracha:", "kukaracha")]
    [InlineData(":kukaracha:azaza:", "kukaracha")]
    public void StringExtensionsTest1(string source, string expectedResult)
    {
        var result = source.GetStringBetweenColons();
        
        result.ShouldBeEquivalentTo(expectedResult);
        
        var logMessage = $"StringExtensionsTest1 - Source: {source}, Expected result : {expectedResult}, Result: {result}";
        _logger.Information(logMessage);
    }
}