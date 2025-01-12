namespace lr4;

public class Person(string fio) : IIdentifieble, INameble
{
    public Guid Id { get; } = Guid.NewGuid();
    public string FIO { get; set; } = fio;
}