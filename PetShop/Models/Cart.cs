namespace PetShop.Models
{
    public class Cart
    {
        public int id { get; set; }
        public int catalog_id { get; set; }
        public string user { get; set; }
        public int count { get; set; }
    }
}
