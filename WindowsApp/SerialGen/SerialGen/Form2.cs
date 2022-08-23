using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SerialGen
{
    public partial class Form2 : Form
    {


        public Form2()
        {
            InitializeComponent();
        }

        private void Form2_Load(object sender, EventArgs e)
        {
            this.ControlBox = false;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //Form1.serials.Add((int)numericUpDown1.Value);
            //Form1.Names.Add(textBox1.Text);

            Boolean pass = true;

            JToken t = Form1.jobj.First;
            for (int i = 0; i < Form1.jobj.Count; i++){
                if (t.Path.Equals(this.textBox1.Text))
                    pass = false;
                t = t.Next;
            }

            if (pass)
            {
                Form1.jobj.Add(textBox1.Text, (int)numericUpDown1.Value);
                Form1.update = true;

                File.WriteAllText(Form1.FileName, JsonConvert.SerializeObject(Form1.jobj));
            }
            else
                MessageBox.Show("This Product already exists");

            this.textBox1.Text = "";
            this.numericUpDown1.Value = 0;

            


            this.Visible = false;
        }

        private void button2_Click_1(object sender, EventArgs e)
        {
            this.Visible = false;
        }
    }
}
