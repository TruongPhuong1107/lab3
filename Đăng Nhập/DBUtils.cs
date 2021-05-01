using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConnectSQLServer
{
    class DBUtils
    {
        public static SqlConnection GetDBConnection()
        {
            string datasource = @"DESKTOP-DQL9P7L\SQLEXPRESS";

            string database = "QLSV2";
            string username = "sa";
            string password = "123456";

            return DBSQLServerUtils.GetDBConnection(datasource, database, username, password);
        }
    }
}
