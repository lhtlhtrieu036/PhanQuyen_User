using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Oracle.ManagedDataAccess.Client;
using System.Text.RegularExpressions;
using System.Configuration;



namespace Test2
{
    public static class globals
    {
        public static string username = "", password = "", host= "DESKTOP-F3EC84V", port="1521", sid = "xe";
        public static string connstring = "Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=DESKTOP-F3EC84V)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=XE)));User Id=SUPERADMIN;Password=0201;";
    }
    public partial class Login_Form : Form
    {
        
        OracleConnection conn = new OracleConnection();
        //OracleDataAdapter adapter;
        //OracleCommand command;

        public Login_Form()
        {
            InitializeComponent();
            //conn.Open();
            //try
            //{
            //    string sql = "select * from DBA_USERS";
            //    command = new OracleCommand(sql, conn);

            //    DataTable data = new DataTable();
            //    adapter = new OracleDataAdapter(command);
            //    adapter.Fill(data);
                
            //    dgv_users.DataSource = data;

            //    string sql1 = "SELECT * FROM DBA_ROLES";
            //    command = new OracleCommand(sql1, conn);

            //    DataTable data2 = new DataTable();
            //    adapter = new OracleDataAdapter(command);
            //    adapter.Fill(data2);
            //    dgv_role.DataSource = data2;



            //    conn.Close();
            //}
            //catch (Exception ex)
            //{
            //    MessageBox.Show(ex.Message);
            //}
            //finally
            //{
            //    conn.Close();
            //}
        }

        private void Login_Form_Load(object sender, EventArgs e)
        {
            username_login_textBox.Focus();
        }
        
        private void login_button_Click(object sender, EventArgs e)
        {



            if (username_login_textBox.Text != admin_acc.username || pw_login_textBox.Text != admin_acc.password)
            {
                MessageBox.Show("LOGIN FAIL!!!", "WARNINGGGGG!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                username_login_textBox.Focus();
                return;
            };

            //CONNECT USER TO DATABASE

            globals.username = username_login_textBox.Text;
            globals.password = pw_login_textBox.Text;
            
            string connString = "Data Source=(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = "
                 + globals.host + ")(PORT = " + globals.port + "))(CONNECT_DATA = (SERVER = DEDICATED)(SERVICE_NAME = "
                 + globals.sid + "))); User ID=" + globals.username + "; Password = " + globals.password;

            try {
                conn.ConnectionString = connString;
                MessageBox.Show("OK", "THANHCONG", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {

                MessageBox.Show(ex.Message);
                //MessageBox.Show("LOGIN FAIL!!!", "WARNINGGGGG!", MessageBoxButtons.OK, MessageBoxIcon.Information);
                //username_login_textBox.Focus();
                return;
            }
            finally
            {
                conn.Close();
            }




            //this.Hide();
            
            //Form1 dglAd = new Form1();
            //dglAd.ShowDialog();
            //this.Close();
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
