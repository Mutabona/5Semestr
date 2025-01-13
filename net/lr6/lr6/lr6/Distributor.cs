namespace lr6;

public class Distributor(EventBus eventBus)
{
    public void Distribute(string product)
    {
        Console.WriteLine($"Distributing product: {product}");
        eventBus.Publish(this, new ProductSended{Product = product});
    }
}