using Serilog;
using Serilog.Debugging;
using Serilog.Events;
using Serilog.Sinks.SystemConsole;
using Shouldly;
using Zadanie;

namespace ZadanieTests
{
    public class StringExtensionTests
    {
        private readonly ILogger _logger;
        private static readonly string LogFilePath = "C:\\Users\\k_dod\\repos\\5Semestr\\tpo\\lr3\\StringExtensionsTestsLogs\\log.log";

        
        public StringExtensionTests()
        {
            Log.Logger = _logger = new LoggerConfiguration()
                .MinimumLevel.Verbose()
                .WriteTo.Console(standardErrorFromLevel: LogEventLevel.Verbose)
                .WriteTo.File(LogFilePath)
                .CreateLogger();
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
            Log.CloseAndFlush();
        }
    }
}