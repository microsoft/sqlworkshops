using Microsoft.EntityFrameworkCore;
using TailspinToysWeb.Models;

namespace TailspinToysWeb.Data
{
    public class TailspinToysContext : DbContext
    {
        public TailspinToysContext(DbContextOptions<TailspinToysContext> options): base(options)
        {
        }

        public DbSet<Game> Games { get; set; }
    }
}