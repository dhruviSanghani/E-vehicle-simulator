using MySqlConnector;
using System.Reflection;

namespace E_vehicle_simulator.Controllers
{
    public class ConfigConnecion
    {
        public MySqlConnection _mySql;
        public ConfigConnecion(MySqlConnection mySql)
        {
            _mySql = mySql;
        }
        public void Open()
        {
            _mySql.Open();
        }
        public void Close()
        {
            _mySql.Close();
        }

        public IEnumerable<T> Query<T>(string sql)
        {
            Open();
            Type TypeT = typeof(T);
            ConstructorInfo ctor = TypeT.GetConstructor(Type.EmptyTypes);
            if (ctor == null)
            {
                throw new InvalidOperationException($"Type {TypeT.Name} does not have a default constructor.");
            }
            using (MySqlCommand cmd = new MySqlCommand(sql, _mySql))
            {
                using (MySqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        T newInst = (T)ctor.Invoke(null);
                        for (int i = 0; i < reader.FieldCount; i++)
                        {
                            string propName = reader.GetName(i);
                            PropertyInfo propInfo = TypeT.GetProperty(propName);
                            if (propInfo != null)
                            {
                                object value = reader.GetValue(i);
                                if (value == DBNull.Value)
                                {
                                    propInfo.SetValue(newInst, null);
                                }
                                else
                                {
                                    propInfo.SetValue(newInst, value);
                                }
                            }
                        }
                        yield return newInst;
                    }
                }
            }
            Close();
        }

    }
}
