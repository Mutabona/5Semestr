namespace lr6;

public class Worker
{
    private readonly EventBus _eventBus;

    public Worker(EventBus eventBus)
    {
        _eventBus = eventBus;
        eventBus.Subscribe<ProductSended>(AcceptProduct);
        eventBus.Subscribe<ProductAccepted>(FinishProduct);
    }

    ~Worker()
    {
        _eventBus.Unsubscribe<ProductSended>(AcceptProduct);
        _eventBus.Unsubscribe<ProductAccepted>(FinishProduct);
    }

    private void AcceptProduct(object sender, ProductSended product)
    {
        Console.WriteLine($"Product accepting: {product.Product}");
        _eventBus.Publish(this, new ProductAccepted{Product = product.Product});
    }

    private void FinishProduct(object sender, ProductAccepted product)
    {
        Console.WriteLine($"Product accepted: {product.Product}");
    }
}