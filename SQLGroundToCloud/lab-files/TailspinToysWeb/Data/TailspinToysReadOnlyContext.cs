using Microsoft.EntityFrameworkCore;
using TailspinToysWeb.Models;

namespace TailspinToysWeb.Data
{
    public class TailspinToysReadOnlyContext : DbContext
    {
        public TailspinToysReadOnlyContext(DbContextOptions<TailspinToysReadOnlyContext> options) : base(options)
        {
        }

        public DbSet<Gamer> Gamers { get; set; }
        public DbSet<Leaderboard> Leaderboard { get; set; }
        public DbQuery<UpdateabilityMessage> Updateability { get; set; }
    }
}