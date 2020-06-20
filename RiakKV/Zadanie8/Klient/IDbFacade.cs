using System.Threading.Tasks;

namespace DefaultNamespace
{
    public interface IDbFacade<T>
    {
        Task<string> AddAsync(T newValue);
        Task AddAsync(T newValue, string key);

        Task UpdateAsync(T newValue, string key);

        Task RemoveAsync(string key);

        Task<T> ReadAsync(string key);
    }
}