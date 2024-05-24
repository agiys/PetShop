using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PetShop.Data;
using PetShop.Models;

namespace PetShop.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CatalogController : ControllerBase
    {
        private readonly AppDbContext _context;

        public CatalogController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet("testconnection")]
        public IActionResult TestConnection()
        {
            bool canConnect = _context.Database.CanConnect();

            if (canConnect)
            {
                return Ok("Database connection is successful.");
            }
            else
            {
                return StatusCode(500, "Failed to connect to the database.");
            }
        }

        [HttpGet("getcategory")]
        public async Task<ActionResult<IEnumerable<CategoryItem>>> GetCategoryItems()
        {
            return await _context.Category.ToListAsync();
        }

        /// <summary>
        /// Получить данные для конктретной категории
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet("getcatalog/{id}")]
        public async Task<ActionResult<IEnumerable<CatalogItem>>> GetCatalogItems(int id)
        {
            var items = await _context.Catalog.Where(c => c.category_id == id).ToListAsync();
            return Ok(items);
        }

        /// <summary>
        /// Получить конкретный элемент (карточку)
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet("getitem/{id}")]
        public async Task<ActionResult<CatalogItemWithFavorite>> GetCatalogItemById(int id,[FromQuery] string user)
        {
            var catalogItem = await _context.Catalog.FindAsync(id);
            if (catalogItem == null)
            {
                return NotFound();
            }
            var favoriteItem = await _context.Favorites
               .Where(f => f.user == user && f.catalog_id == id)
               .ToListAsync();
            var cartItem = await _context.Cart
                .Where(f => f.user == user && f.catalog_id == id)
                .ToListAsync();
            var result = new CatalogItemWithFavorite
                {
                    Id = catalogItem.id,
                    Name = catalogItem.name,
                    Description = catalogItem.description,
                    Image_url = catalogItem.image_url,
                    Price = catalogItem.price,
                    IsFavorite = favoriteItem.Any(f => f.catalog_id == catalogItem.id),
                    FavoritesItemId = favoriteItem.FirstOrDefault(f => f.catalog_id == catalogItem.id)?.id,
                    CartItemId = cartItem.FirstOrDefault(f => f.catalog_id == catalogItem.id)?.id,
                    CartItemCount = cartItem.FirstOrDefault(f => f.catalog_id == catalogItem.id)?.count
                };

            return result;
        }

        [HttpGet("getauthcatalog/{id}")]
        public async Task<ActionResult<IEnumerable<CatalogItemWithFavorite>>> GetCatalogItems(int id, [FromQuery] string user)
        {
            var catalogItems = await _context.Catalog.Where(c => c.category_id == id).ToListAsync();

            var favoriteItems = await _context.Favorites
                .Where(f => f.user == user)
                .ToListAsync();
            var cartItems = await _context.Cart
                .Where(f => f.user == user)
                .ToListAsync();

            var result = catalogItems
                .Select(catalogItem => new CatalogItemWithFavorite
                {
                    Id = catalogItem.id,
                    Name = catalogItem.name,
                    Description = catalogItem.description,
                    Image_url = catalogItem.image_url,
                    Price = catalogItem.price,
                    IsFavorite = favoriteItems.Any(f => f.catalog_id == catalogItem.id),
                    FavoritesItemId = favoriteItems.FirstOrDefault(f => f.catalog_id == catalogItem.id)?.id,
                    CartItemId = cartItems.FirstOrDefault(f => f.catalog_id == catalogItem.id)?.id,
                    CartItemCount = cartItems.FirstOrDefault(f => f.catalog_id == catalogItem.id)?.count
                })
                .ToList();

            return Ok(result);
        }

        public class CatalogItemWithFavorite
        {
            public int Id { get; set; }
            public string Name { get; set; }
            public string Description { get; set; }
            public string Image_url { get; set; }
            public bool IsFavorite { get; set; }
            public int? FavoritesItemId { get; set; }
            public int? CartItemId { get; set; }
            public int? CartItemCount { get; set; }
            public int? Price { get; set; }
        }

    }
}
