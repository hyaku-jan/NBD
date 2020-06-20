using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using DefaultNamespace;
using Newtonsoft.Json;
using JsonSerializer = Newtonsoft.Json.JsonSerializer;

namespace Klient
{
    public class RiakDbFacade : IDbFacade<RiakEntity>
    {
        private Uri _riakUrl;
        private string _bucket;

        public RiakDbFacade(string riakUrl, string bucketName)
        {
            _riakUrl = new Uri(riakUrl);
            _bucket = bucketName;
        }


        public async Task<string> AddAsync(RiakEntity newValue)
        {
            var jsonData = JsonConvert.SerializeObject(newValue);

            var content = new StringContent(jsonData, Encoding.UTF8, "application/json");

            var requestUri = new Uri(_riakUrl, $"riak/{_bucket}");

            using var client = new HttpClient();
            var response = await client.PostAsync(requestUri, content);

            Console.WriteLine($"Response code: {response.StatusCode}");

            return response.Headers
                .SingleOrDefault(x => "LOCATION".Equals(x.Key.ToUpper()))
                .Value.Single()
                .Split('/').Last();
        }

        public async Task AddAsync(RiakEntity newValue, string key)
        {
            var jsonData = JsonConvert.SerializeObject(newValue);

            var content = new StringContent(jsonData, Encoding.UTF8, "application/json");

            var requestUri = new Uri(_riakUrl, $"riak/{_bucket}/{key}");

            using var client = new HttpClient();

            Console.WriteLine($"Response code: {(await client.PutAsync(requestUri, content)).StatusCode}");
        }

        public async Task UpdateAsync(RiakEntity newValue, string key)
        {
            await AddAsync(newValue, key);
        }

        public async Task RemoveAsync(string key)
        {
            var requestUri = new Uri(_riakUrl, $"riak/{_bucket}/{key}");

            using var client = new HttpClient();

            Console.WriteLine($"Response code: {(await client.DeleteAsync(requestUri)).StatusCode}");
        }

        public async Task<RiakEntity> ReadAsync(string key)
        {
            var requestUri = new Uri(_riakUrl, $"riak/{_bucket}/{key}");

            using var client = new HttpClient();

            var response = await client.GetAsync(requestUri);

            if (response.StatusCode == HttpStatusCode.NotFound)
            {
                throw new KeyNotFoundException(key);
            }

            return JsonConvert.DeserializeObject<RiakEntity>(await response.Content.ReadAsStringAsync());
        }
    }
}