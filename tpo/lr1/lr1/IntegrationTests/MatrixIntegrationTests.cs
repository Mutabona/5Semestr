using Serilog;
using Serilog.Debugging;
using Serilog.Events;
using Shouldly;
using Xunit.Abstractions;
using Zadanie;

namespace IntegrationTests
{
    public class MatrixIntegrationTests
    {
        private readonly ITestOutputHelper output;
        private static readonly string LogFilePath = @"C:\Users\k_dod\source\repos\5Semestr\tpo\lr4\log.log";
        
        public MatrixIntegrationTests(ITestOutputHelper output)
        {
            this.output = output;
            Log.Logger = new LoggerConfiguration()
                .MinimumLevel.Verbose()
                .WriteTo.File(LogFilePath)
                .CreateLogger();
            
            SelfLog.Enable(Console.Error);
        }
        
        [Fact]
        public void Create_MatrixCounter_Test()
        {
            // Arrange
            var builder = new MatrixCounter.MatrixCounterBuilder();
            
            // Act
            MatrixCounter? matrixCounter = builder.Build();
            
            // Assert
            matrixCounter.ShouldNotBeNull().ShouldBeOfType<MatrixCounter>();
            
            string matrixCounterType = matrixCounter == null ? "undefined" : matrixCounter.GetType().ToString();
            Log.Information($"Creating matrix counter. Expected type: {typeof(MatrixCounter)}, Result: {matrixCounterType} ");
            output.WriteLine($"Creating matrix counter. Expected type: {typeof(MatrixCounter)}, Result: {matrixCounterType} ");
            
            Log.CloseAndFlush();
        }
    }
}