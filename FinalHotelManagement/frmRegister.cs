using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FinalHotelManagement
{
    public partial class frmRegister : Form
    {
        public frmRegister()
        {
            InitializeComponent();
        }

        private void readOnlyUsername_Load(object sender, EventArgs e)
        {

        }

        // LINK METHODS
        private void lnkSignup_Click(object sender, EventArgs e)
        {
            pnlLogin.Visible = false;
            picLogin.Visible = false;
        }
        private void lnkLogIn_Click(object sender, EventArgs e)
        {
            pnlLogin.Visible = true;
            picLogin.Visible = true;
        }

        // BUTTON METHODS
        private void btnLogin_Click(object sender, EventArgs e)
        {

        }

        // PLACEHOLDER METHODS
        private void txtUsername_Enter(object sender, EventArgs e)
        {
            if (txtUsername.Text == "Enter your username...")
            {
                txtUsername.Text = "";
                txtUsername.ForeColor = Color.Black;
            }
        }

        private void txtUsername_Leave(object sender, EventArgs e)
        {
            if (txtUsername.Text == "")
            {
                txtUsername.Text = "Enter your username...";
                txtUsername.ForeColor = Color.Silver;
            }
        }

        private void txtPassword_Enter(object sender, EventArgs e)
        {
            if (txtPassword.Text == "Enter your password...")
            {
                txtPassword.Text = "";
                txtPassword.UseSystemPasswordChar = true;
                txtPassword.ForeColor = Color.Black;
            }
        }

        private void txtPassword_Leave(object sender, EventArgs e)
        {
            if (txtPassword.Text == "")
            {
                txtPassword.Text = "Enter your password...";
                txtPassword.UseSystemPasswordChar = false;
                txtPassword.ForeColor = Color.Silver;
            }
        }

    }
}
