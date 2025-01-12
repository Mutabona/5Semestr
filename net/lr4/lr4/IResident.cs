namespace lr4;

public interface IResident
{
    int? Room { get; }
    
    void SetRoom(int room);
    
    void ResetRoom();
}