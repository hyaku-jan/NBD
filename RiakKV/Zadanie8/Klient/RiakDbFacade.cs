using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using DefaultNamespace;
using Newtonsoft.Json;

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
            
            using (var client = new HttpClient())
            {
                var response = await client.PostAsync(requestUri, content);

                return response.Headers
                    .SingleOrDefault(x => "LOCATION".Equals(x.Key.ToUpper()))
                    .Value.Single()
                    .Split('/').Last();
            }

        }

        public async Task AddAsync(RiakEntity newValue, string key)
        {
            var jsonData = JsonConvert.SerializeObject(newValue);
            
            var content = new StringContent(jsonData, Encoding.UTF8, "application/json");

            var requestUri = new Uri(_riakUrl, $"riak/{_bucket}/{key}");

            using var client = new HttpClient();
            
            await client.PostAsync(requestUri, content);
            
        }

        public Task UpdateAsync(RiakEntity newValue, string key)
        {
            throw new System.NotImplementedException();
        }

        public Task RemoveAsync(string key)
        {
            throw new System.NotImplementedException();
        }

        public Task<RiakEntity> ReadAsync(string key)
        {
            throw new System.NotImplementedException();
        }
    }
}