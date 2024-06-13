using Microsoft.AspNetCore.Mvc;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.IdentityModel.Tokens;
using PetShop.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;
using PetShop.Models;

namespace PetShop.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly AppDbContext _context;

        public AuthController(AppDbContext context)
        {
            _context = context;
        }

        [HttpPost("login")]
        public async Task<ActionResult<LoginResponse>> Login(LoginRequest request)
        {
            var user = await _context.Users.FirstOrDefaultAsync(u => u.Name == request.Login && u.Password == request.Password);
            if (user == null )
            {
                return Unauthorized("Неверный логин или пароль");
            }

            // Создание JWT
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes("45456465156fg1f5g1fd54fd84789d74fg97fd9g8fd7g98fd7g89fdgf7fd9g7fd89f98");
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                    {
                        new Claim(ClaimTypes.Name, user?.Name.ToString())
                    }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            var tokenString = tokenHandler.WriteToken(token);

            return Ok(new LoginResponse { Token = tokenString, Username=user.Name });
        }

        [HttpGet("user")]
        [Authorize]
        public IActionResult GetUser()
        {
            var username = User.FindFirstValue(ClaimTypes.Name);
            return Ok(new { username });
        }

        public class LoginRequest
        {
            public string Login { get; set; }
            public string Password { get; set; }
        }

        public class LoginResponse
        {
            public string Token { get; set; }
            public string Username { get; set; }
        }
        [HttpPost("register")]
        public async Task<ActionResult<LoginResponse>> Register(LoginRequest request)
        {
        try { 
            var existingUser = await _context.Users.FirstOrDefaultAsync(u => u.Name == request.Login);
            if (existingUser != null)
            {
                return Conflict("Пользователь с таким именем уже существует");
            }
            var newUser = new Users
            {
                Name = request.Login,
                Password = request.Password
                // Другие поля пользователя, если они есть
            };

            _context.Users.Add(newUser);
            await _context.SaveChangesAsync();

            return Ok("Пользователь успешно зарегистрирован");
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Произошла ошибка при регистрации пользователя: {ex.Message}");
        }
      }
    }
}
