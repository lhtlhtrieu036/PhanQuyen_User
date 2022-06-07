using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Oracle.ManagedDataAccess.Client;

namespace Test2
{
    public static class admin_acc
    {
        public static string username = "SUPERADMIN";
        public static string password = "0201";

        //public static bool CheckValue(string sql)
        //{
        //    OracleDataAdapter dap = new OracleDataAdapter(sql, Con);
        //    DataTable table = new DataTable();
        //    dap.Fill(table);
        //    if (table.Rows.Count > 0)
        //        return true;
        //    else return false;
        //}

    }
}
