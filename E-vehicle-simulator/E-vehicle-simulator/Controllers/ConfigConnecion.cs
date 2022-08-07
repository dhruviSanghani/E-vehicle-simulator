using MySqlConnector;
using Newtonsoft.Json;
using System.Reflection;
using System.Text;

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
        static IEnumerable<PropertyInfo> GetPropertiesWithAttribute<TType, TAttribute>()
        {
            Func<PropertyInfo, bool> matching =
                    property => !property.GetCustomAttributes(typeof(TAttribute), false)
                                        .Any();

            return typeof(TType).GetProperties().Where(matching);
        }
        public bool ExecuteInsertQuery<T>(string table, T t)
        {
            Open();
            Type TypeT = typeof(T);
            ConstructorInfo ctor = TypeT.GetConstructor(Type.EmptyTypes);
            if (ctor == null)
            {
                throw new InvalidOperationException($"Type {TypeT.Name} does not have a default constructor.");
            }
            
            List<PropertyInfo> props = GetPropertiesWithAttribute<T, JsonIgnoreAttribute>().ToList();
            var values = new StringBuilder();
            foreach (PropertyInfo prop in props)
            {
                values.Append(",");
                if (prop.PropertyType == typeof(string))
                {
                    values.Append("'");
                    values.Append(prop.GetValue(t, null));
                    values.Append("'");
                }
                else
                {
                    values.Append(prop.GetValue(t, null));
                }
            }
            
            string sql = String.Format("INSERT INTO " + table + "({0}) VALUES({1})",
                 string.Join(",", props.Select(p => p.Name).ToArray()),
                values.ToString().TrimStart(','));

            try
            {

                //foreach (PropertyInfo prop in props)
                //{

                //    cmd.Parameters.AddWithValue(prop.Name, prop.GetValue(t, null));
                //}
                using (MySqlCommand cmd = new MySqlCommand())
                {
                    cmd.Connection = _mySql;
                    cmd.CommandText = sql;
                    cmd.ExecuteNonQuery();
                }
                Close();
                return true;
            }
            catch 
            {
                return false;
            }
        }

        public bool ExecuteUpdateQuery<T>(string table, T t)
        {
            Open();
            Type TypeT = typeof(T);
            ConstructorInfo ctor = TypeT.GetConstructor(Type.EmptyTypes);
            if (ctor == null)
            {
                throw new InvalidOperationException($"Type {TypeT.Name} does not have a default constructor.");
            }

            List<PropertyInfo> props = GetPropertiesWithAttribute<T, JsonIgnoreAttribute>().ToList();
            var values = new StringBuilder();
            values.Append("UPDATE ");
            values.Append(table);
            values.Append(" SET ");
            foreach (PropertyInfo prop in props)
            {
                values.Append(prop.Name);
                values.Append("=");
                if (prop.PropertyType == typeof(string))
                {
                    values.Append("'");
                    values.Append(prop.GetValue(t, null));
                    values.Append("'");
                }
                else
                {
                    values.Append(prop.GetValue(t, null));
                }
                values.Append(",");
            }            
//            UPDATE `evehicle`.`users`
//SET
//`UserID` = <{ UserID: }>,
//`UserName` = <{ UserName: }>,
//`UserTypeID` = <{ UserTypeID: }>,
//`Password` = <{ Password: }>,
//`FullName` = <{ FullName: }>,
//`Phone` = <{ Phone: }>,
//`Email` = <{ Email: }>
//WHERE `UserID` = <{ expr}>;

            string sql = String.Format(values.ToString().TrimEnd(',')+" Where "+ props[0].Name+"="+ props[0].GetValue(t, null));

            try
            {

                //foreach (PropertyInfo prop in props)
                //{

                //    cmd.Parameters.AddWithValue(prop.Name, prop.GetValue(t, null));
                //}
                using (MySqlCommand cmd = new MySqlCommand())
                {
                    cmd.Connection = _mySql;
                    cmd.CommandText = sql;
                    cmd.ExecuteNonQuery();
                }
                Close();
                return true;
            }
            catch
            {
                return false;
            }
        }

    }
}
