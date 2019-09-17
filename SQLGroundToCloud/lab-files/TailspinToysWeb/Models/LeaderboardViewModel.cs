using System.ComponentModel;

namespace TailspinToysWeb.Models
{
    public class LeaderboardViewModel
    {
        public int Position { get; set; }
        [DisplayName("Gamer Tag")]
        public string GamerTag { get; set; }
        public string Name { get; set; }
        [DisplayName("Score")]
        public int GamerScore { get; set; }
        public int Diff { get; set; }
        [DisplayName("Games Played")]
        public int GamesPlayed { get; set; }
        [DisplayName("Online")]
        public bool IsOnline { get; set; }
    }
}