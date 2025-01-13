namespace lr6;

public class EventBus
{
    private readonly Dictionary<Type, List<Delegate>>_handlers = new();

    public void Subscribe<TEvent>(Delegate handler) where TEvent : EventArgs
    {
        var eventType = typeof(TEvent);
        
        if (!_handlers.ContainsKey(eventType))
            _handlers.Add(eventType, new List<Delegate>());
        
        _handlers[eventType].Add(handler);
    }

    public void Unsubscribe<TEvent>(Delegate handler) where TEvent : EventArgs
    {
        var eventType = typeof(TEvent);
        if (_handlers.ContainsKey(eventType) && _handlers[eventType].Contains(handler))
            _handlers[eventType].Remove(handler);
    }

    public void Publish<TEvent>(object sender, TEvent eventArgs) where TEvent : EventArgs
    {
        Type eventType = typeof(TEvent);
        if (_handlers.ContainsKey(eventType))
        {
            foreach (var handler in _handlers[eventType])
            {
                handler.DynamicInvoke(sender, eventArgs);
            }
        }
    }
}