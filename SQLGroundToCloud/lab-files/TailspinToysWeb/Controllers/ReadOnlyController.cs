using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using TailspinToysWeb.Data;
using TailspinToysWeb.Models;

namespace TailspinToysWeb.Controllers
{
    public class ReadOnlyController : Controller
    {
        private readonly TailspinToysReadOnlyContext _context;

        public ReadOnlyController(TailspinToysReadOnlyContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            var query = new RawSqlString("SELECT DATABASEPROPERTYEX(DB_NAME(), 'Updateability') AS Message");
            var message = _context.Updateability.FromSql(query);

            ViewData["Message"] = message.First().Message;

            var topScore = _context.Leaderboard.Max(s => s.GamerScore);

            var lbQuery = from l in _context.Leaderboard
                          join g in _context.Gamers on l.GamerId equals g.Id
                          orderby l.GamerScore descending
                          select new LeaderboardViewModel
                          {
                              GamerTag = g.Tag,
                              Name = $"{g.FirstName} {g.LastName}",
                              GamerScore = l.GamerScore,
                              Diff = l.GamerScore - topScore,
                              GamesPlayed = l.GamesPlayed,
                              IsOnline = l.IsOnline
                          };

            // Return the top 100 players
            var leaderboard = lbQuery.Take(100).AsEnumerable()
                .Select((player, index) => new LeaderboardViewModel
                {
                    Position = index + 1,
                    GamerTag = player.GamerTag,
                    Name = player.Name,
                    GamerScore = player.GamerScore,
                    Diff = player.Diff,
                    GamesPlayed = player.GamesPlayed,
                    IsOnline = player.IsOnline
                })
                .ToList();

            return View(leaderboard);
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}