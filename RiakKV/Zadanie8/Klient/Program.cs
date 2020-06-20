using System;
using System.Threading.Tasks;
using DefaultNamespace;

namespace Klient
{
    class Program
    {
        static async Task Main(string[] args)
        {
            string key = "foobar";

            string url = "http://localhost:8098";

            IDbFacade<RiakEntity> facade = new RiakDbFacade(url, "s21748");

            Console.WriteLine("Adding");
            await facade.AddAsync(new RiakEntity() {BoleanProperty = false, IntProperty = 144, StringProperty = "Baz"});

            Console.WriteLine("Reading");
            var entity = await facade.ReadAsync(key);
            Console.WriteLine(entity.ToString());
            
            Console.WriteLine("Updating");
            entity.StringProperty = "git gud";
            await facade.UpdateAsync(entity, key);
            
            Console.WriteLine("Reading again");
            var entity1 = await facade.ReadAsync(key);
            Console.WriteLine(entity1.ToString());

            Console.WriteLine("Removing");
            await facade.RemoveAsync(key);

            Console.WriteLine("Reading after deletion");
            await facade.ReadAsync(key);
        }
    }
}
