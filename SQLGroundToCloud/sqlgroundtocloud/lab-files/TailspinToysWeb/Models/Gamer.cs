using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace TailspinToysWeb.Models
{
    [Table("Gamer", Schema = "dbo")]
    public class Gamer
    {
        [Key]
        public int Id { get; set; }
        public string Tag { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public int? Age { get; set; }
        public string LoginEmail { get; set; }
    }
}