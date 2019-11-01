using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace TailspinToysWeb.Models
{
    [Table("Game", Schema = "dbo")]
    public class Game
    {
        [Key]
        public int Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        [NotMapped]
        public string DescriptionShort
        {
            get { return Description.Substring(0, Description.IndexOf(".") + 1); }
        }
        public string Rating { get; set; }
        public bool IsOnlineMultiplayer { get; set; }
    }
}