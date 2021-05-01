using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConnectSQLServer
{
    class DBSQLServerUtils
    {
       
            public static SqlConnection
                     GetDBConnection(string datasource, string database, string username, string password)
            {
            //
            // Data Source=DESKTOP-DQL9P7L;Initial Catalog=QLSV2;User ID=sa;Password=123456
            string connString = @"Data Source=" + datasource + ";Initial Catalog="
                        + database + ";Persist Security Info=True;User ID=" + username + ";Password=" + password;
            SqlConnection conn = new SqlConnection(connString);

                return conn;
            }   
    }
}
