using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using System.Linq;
using TailspinToysWeb.Data;
using TailspinToysWeb.Models;

namespace TailspinToysWeb.Controllers
{
    public class HomeController : Controller
    {
        private readonly TailspinToysContext _context;

        public HomeController(TailspinToysContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            var games = _context.Games;
            return View(games);
        }

        public IActionResult GameDetails(int id)
        {
            var game = _context.Games.First(g => g.Id == id);
            return View(game);
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}