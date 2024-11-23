namespace lr3;

internal sealed class Person
{
    private string _name;
    private int _age;
    public string Name { get => _name; set => _name = value; }
    public int Age 
    { 
        get => _age ;
        set
        {
            if (value <= 18) throw new Exception("Invalid age");
            _age = value;
        }
    }

    public void PrintPersonInfo()
    {
        var name = string.IsNullOrEmpty(Name) ? "Unnamed" : Name;
        Console.WriteLine($"Name: {name}, Age: {Age}");
    }
}