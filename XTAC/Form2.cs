using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using PlayerLib;

namespace XTAC
{
    public partial class TestClient : Form
    {
        Game game;
        string fileName;
        public TestClient()
        {
            InitializeComponent();
        }

        private void TestClient_Load(object sender, EventArgs e)
        {

        }

        public void SetFile(string fileName)
        {
            this.fileName = fileName;
            game = Game.GetInstance();
            game.SetOutputWindow(outputWindow);
            game.SetGameData(fileName);
            game.Run();
            outputWindow.DeselectAll();
            inputWindow.Focus();
        }

        private void ReloadBtn_Click(object sender, EventArgs e)
        {
            if (fileName != null)
            {
                outputWindow.Text = "";
                game.SetGameData(fileName);
                game.Run();
            }
        }

        private void outputWindow_TextChanged(object sender, EventArgs e)
        {

        }

        private void inputWindow_TextChanged(object sender, EventArgs e)
        {

        }

        private void inputWindow_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (game != null)
            {
                if (e.KeyChar == '\r')
                {
                    outputWindow.AppendText(inputWindow.Text + "\r\n");

                    game.AcceptCommand(inputWindow.Text);


                    inputWindow.Clear();
                    inputWindow.Focus();

                    outputWindow.SelectionStart = outputWindow.TextLength;
                    outputWindow.ScrollToCaret();
                    e.Handled = true;
                }
            }
        }

    }
}
