namespace lr4;

public class Resident(string fio) : Person(fio), IResident
{
    public int? Room { get; private set; }
    public void SetRoom(int room)
    {
        Room = room;
        Console.WriteLine($"Resident {FIO} is in room {Room} now");
    }

    public void ResetRoom()
    {
        Room = null;
        Console.WriteLine($"Resident {FIO} is homeless now");
    }
}