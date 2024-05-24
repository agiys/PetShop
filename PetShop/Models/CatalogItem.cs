namespace PetShop.Models
{
    public class CatalogItem
    {
        public int id { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public int category_id { get; set; }
        public string? image_url { get; set; }
        public int price { get; set; }

    }
}
