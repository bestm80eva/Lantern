using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml;
using XMLtoAdv;
using System.IO;
using System.Xml.Serialization;
using XTAC;
using PlayerLib;

namespace Player
{
    public partial class Form1 : Form
    {
        Xml xproject;
        Game game;
        
        public Form1()
        {
            InitializeComponent();
        }

        private void loadToolStripMenuItem_Click(object sender, EventArgs e)
        {
            OpenFileDialog openFileDialog1 = new OpenFileDialog();
            openFileDialog1.Filter = "XML Files|*.xml";
            openFileDialog1.Title = "Select an XML File";

            // Show the Dialog.  
            // If the user clicked OK in the dialog and  
            // a .CUR file was selected, open it.  
            if (openFileDialog1.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                System.Xml.Serialization.XmlSerializer reader = new XmlSerializer(typeof(Xml));

                // Read the XML file.
               // StreamReader file = new StreamReader(openFileDialog1.FileName);
                string fileName = openFileDialog1.FileName;

//                // Deserialize the content of the file into a Book object.
  //              xproject = (Xml)reader.Deserialize(file);
                
  //              file.Close();
                 
                game = Game.GetInstance();
                game.SetOutputWindow(outputWindow);
                game.SetGameData(fileName);
                game.Run();
            }
        }



        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (game != null)
            {
                game.AcceptCommand(textBox1.Text);
                textBox1.Clear();
                textBox1.Focus();
            }
        }

        private void textBox1_KeyDown(object sender, KeyEventArgs e)
        {
            if (game != null)
            {
                if (e.KeyCode == Keys.Enter)
                {
                    outputWindow.AppendText(textBox1.Text + "\r\n");

                    game.AcceptCommand(textBox1.Text);

 
                    textBox1.Clear();
                    textBox1.Focus();

                    outputWindow.SelectionStart = outputWindow.TextLength;
                    outputWindow.ScrollToCaret();

                }
            }
        }
    }
}
