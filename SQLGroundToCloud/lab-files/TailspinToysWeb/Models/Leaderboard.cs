using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace TailspinToysWeb.Models
{
    [Table("Leaderboard", Schema = "dbo")]
    public class Leaderboard
    {
        [Key]
        public int GamerId { get; set; }
        public int GamerScore { get; set; }
        public int GamesPlayed { get; set; }
        public bool IsOnline { get; set; }
    }
}