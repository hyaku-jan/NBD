using Newtonsoft.Json;

namespace Klient
{
    public class RiakEntity
    {
        public string StringProperty { get; set; }
        public int IntProperty { get; set; }
        public bool BoleanProperty { get; set; }

        public override string ToString()
        {
            return JsonConvert.SerializeObject(this);
        }
    }
}