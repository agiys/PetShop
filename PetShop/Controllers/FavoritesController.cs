using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PetShop.Data;
using PetShop.Models;

namespace PetShop.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class FavoritesController : ControllerBase
    {
        private readonly AppDbContext _context;

        public FavoritesController(AppDbContext context)
        {
            _context = context;
        }
        [HttpPost("getfavorites")]
        public async Task<ActionResult<IEnumerable<CatalogItemWithFavoritesId>>> GetFavoritesItems([FromBody] UserViewModel payload)
        {
            if (payload == null || string.IsNullOrEmpty(payload.User))
            {
                return BadRequest("Неверные входные данные");
            }

            var favoritesItems = await _context.Favorites.Where(c => c.user == payload.User).ToListAsync();
            var catalogIds = favoritesItems.Select(c => c.catalog_id).Distinct();
            var catalogItems = await _context.Catalog.Where(c => catalogIds.Contains(c.id)).ToListAsync();

            var result = catalogItems
                .Select(catalogItem => new CatalogItemWithFavoritesId
                {
                    Id = catalogItem.id,
                    Name = catalogItem.name,
                    Description = catalogItem.description,
                    Image_url = catalogItem.image_url,
                    Price = catalogItem.price,
                    FavoritesItemId = favoritesItems.FirstOrDefault(f => f.catalog_id == catalogItem.id)?.id,
                })
                .ToList();

            return Ok(result);
        }
        public class CatalogItemWithFavoritesId
        {
            public int Id { get; set; }
            public string Name { get; set; }
            public string Description { get; set; }
            public string Image_url { get; set; }
            public int? FavoritesItemId { get; set; }
            public int Price { get; set; }
        }


        public class UserViewModel
        {
            public string? User { get; set; }
        }

        [Authorize]
        [HttpPost("additem")]
        public async Task<ActionResult> AddFavoriteItem([FromBody] AddFavoriteItemRequest request)
        {
            if (request == null || string.IsNullOrEmpty(request.UserName))
            {
                return BadRequest("Некоректный запрос");
            }

            var existingFavoriteItem = await _context.Favorites
                .FirstOrDefaultAsync(f => f.catalog_id == request.CatalogId && f.user == request.UserName);

            if (existingFavoriteItem != null)
            {
                return Conflict(new { message = "Карточка уже в избраном" });
            }

            var favoriteItem = new Favorites
            {
                catalog_id = request.CatalogId,
                user = request.UserName
            };

            _context.Favorites.Add(favoriteItem);
            await _context.SaveChangesAsync();

            return Ok(new { message = "Карточка успешно добавлена", favoritesItemId = favoriteItem.id });
        }
        public class AddFavoriteItemRequest
        {
            public int CatalogId { get; set; }
            public string UserName { get; set; }
        }
        [Authorize]
        [HttpDelete("deleteitem")]
        public async Task<ActionResult> DeliteCartItems([FromBody] int favoriteItemId)
        {
            if (favoriteItemId <= 0)
            {
                return BadRequest("Неверное ID.");
            }

            var cartItem = await _context.Favorites.FindAsync(favoriteItemId);

            if (cartItem == null)
            {
                return NotFound("Элемент не найден.");
            }
            else
            {
                _context.Favorites.Remove(cartItem);
            }

            await _context.SaveChangesAsync();

            return Ok("Элемент успешно удален или уменьшен.");
        }
    }
}
