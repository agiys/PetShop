using Microsoft.EntityFrameworkCore;
using PetShop.Models;

namespace PetShop.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options)
            : base(options)
        {
        }

        public DbSet<CatalogItem> Catalog { get; set; }
        public DbSet<CategoryItem> Category { get; set; }
        public DbSet<Cart> Cart { get; set; }
        public DbSet<Favorites> Favorites { get; set; }
        public DbSet<Users> Users { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<CatalogItem>().ToTable("catalog");
            modelBuilder.Entity<CategoryItem>().ToTable("category");
            modelBuilder.Entity<Cart>().ToTable("cart");
            modelBuilder.Entity<Favorites>().ToTable("favorites");
            modelBuilder.Entity<Users>().ToTable("Users");
            modelBuilder.Entity<CatalogItem>().HasKey(c => c.id);
            modelBuilder.Entity<CategoryItem>().HasKey(c => c.id);
            modelBuilder.Entity<Cart>().HasKey(c => c.id);
            modelBuilder.Entity<Favorites>().HasKey(c => c.id);
            modelBuilder.Entity<Users>().HasKey(c => c.id);
        }
    }
}
