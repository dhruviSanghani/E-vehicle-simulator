namespace E_vehicle_simulator.Controllers
{
    public interface IConfigConnection
    {
        IEnumerable<T> Query<T>(string sql);
    }
}
