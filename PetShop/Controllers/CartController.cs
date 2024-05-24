using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PetShop.Data;
using PetShop.Models;

namespace PetShop.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CartController : ControllerBase
    {
        private readonly AppDbContext _context;

        public CartController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("getcart")]
        public async Task<ActionResult<IEnumerable<CatalogItemWithCartId>>> GetCartItems([FromBody] UserViewModel payload)
        {
            if (payload == null || string.IsNullOrEmpty(payload.User))
            {
                return BadRequest("Пользователь не передан");
            }

            var cartItems = await _context.Cart
                .Where(c => c.user == payload.User)
                .ToListAsync();

            var catalogIds = cartItems.Select(c => c.catalog_id).Distinct();

            var catalogItems = await _context.Catalog
                .Where(c => catalogIds.Contains(c.id))
                .ToListAsync();

            var result = catalogItems
                .Select(catalogItem => new CatalogItemWithCartId
                {
                    Id = catalogItem.id,
                    Name = catalogItem.name,
                    Description = catalogItem.description,
                    Image_url = catalogItem.image_url,
                    Price = catalogItem.price,
                    CartItemId = cartItems.FirstOrDefault(cartItem => cartItem.catalog_id == catalogItem.id)?.id,
                    Count = cartItems.FirstOrDefault(cartItem => cartItem.catalog_id == catalogItem.id)?.count ?? 0
                })
                .ToList();

            return Ok(result);
        }

        public class UserViewModel
        {
            public string User { get; set; }
        }


        public class CatalogItemWithCartId
        {
            public int Id { get; set; }
            public string Name { get; set; }
            public string Description { get; set; }
            public string Image_url { get; set; }
            public int? CartItemId { get; set; }
            public int? Count { get; set; }
            public int? Price { get; set; }
        }

        [Authorize]
        [HttpDelete("deletecartitem")]
        public async Task<ActionResult> DeliteCartItems([FromBody] int cartItemId)
        {
            if (cartItemId <= 0)
            {
                return BadRequest("Неверное ID.");
            }

            var cartItem = await _context.Cart.FindAsync(cartItemId);

            if (cartItem == null)
            {
                return NotFound("Элемент не найден.");
            }

            if (cartItem.count > 1)
            {
                cartItem.count -= 1;
                _context.Cart.Update(cartItem);
            }
            else
            {
                _context.Cart.Remove(cartItem);
            }

            await _context.SaveChangesAsync();

            return Ok("Элемент успешно удален или уменьшен.");
        }

        [Authorize]
        [HttpPost("addcartitem")]
        public async Task<ActionResult> AddCartItems([FromBody] AddCartItemRequest request)
        {
            var existingCartItem = await _context.Cart
                .FirstOrDefaultAsync(c => c.catalog_id == request.CatalogId && c.user == request.UserName);

            if (existingCartItem != null)
            {
                existingCartItem.count += 1;
                _context.Cart.Update(existingCartItem);
            }
            else
            {
                var newCartItem = new Cart
                {
                    catalog_id = request.CatalogId,
                    user = request.UserName,
                    count = 1 // Assuming new items are added with count of 1
                };
                _context.Cart.Add(newCartItem);
            }

            await _context.SaveChangesAsync();

            var cartItem = await _context.Cart
                .FirstOrDefaultAsync(c => c.catalog_id == request.CatalogId && c.user == request.UserName);

            return Ok(new { message = "Элемент добавлен в корзину", cartItemId = cartItem?.id, cartItemCount = cartItem?.count});
        }

        public class AddCartItemRequest
        {
            public int CatalogId { get; set; }
            public string UserName { get; set; }
        }

    }
}
