using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using bpac;
using Timer = System.Windows.Forms.Timer;

namespace SerialGen
{

    public partial class Form1 : Form
    {
        public static bool update = false;
        public static JObject jobj;
        public static string FileName = "Items.json";
        public static Form2 newProduct;

        string template = "Serialtemplate.LBX";

        //JObject jobj;
        int first = 0;
        int count = 1;
        int last = 0;
        string lotnum = "";
        //Form2 newProduct;
        Timer timer;

        public Form1()
        {
            InitializeComponent();
        }

        private string Selected = "";

        private void TimerTick(System.Object myObject,EventArgs myEventArgs) {
            if (update){
                timer.Stop();

            clearlistBox();
            populatelistBox();

            timer.Start();
            update = false;
            }
        }

        private void Form1_Load(object sender, EventArgs e){
            timer = new Timer();
            timer.Interval = 100;
            timer.Tick += new EventHandler(TimerTick);

            timer.Start();

            

            newProduct = new Form2();
            Selected = "";

            populatelistBox();
        }

        private void listBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            try{
                Selected = listBox1.Text;
                first = jobj.GetValue(Selected).Value<int>();
                last = first + (count-1);

                label2.Text = first + " -> " + last;
            }
            catch(Exception ext){}
        }

        private void button1_Click(object sender, EventArgs e)
        {
            richTextBox1.Text = "";

            count = (int)numericUpDown1.Value+1;
            last = count - 1;
            //last += (count-1);

            if (first >= last)
                last = first;

            label2.Text = first + " -> " + last;

            string str = "";
            string lastStr = "";

            for (var i=0; i<count-1; i++){
                lastStr = "" + ((first + 1) + i);

                while (lastStr.Length < 4)
                    lastStr = "0"+ lastStr;

                str += lotnum+"-"+ lastStr +" ";
            }

            richTextBox1.Text = str;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            newProduct.Visible = true;
        }

        void populatelistBox()
        {
            using (StreamReader r = new StreamReader(FileName))
            {
                string text = r.ReadToEnd();
                jobj = JObject.Parse(text);

                JToken t = jobj.First;
                for (int i = 0; i < jobj.Count; i++)
                {
                    listBox1.Items.Add(t.Path);

                    //Names.Add(t.Path);
                    //serials.Add(jobj.GetValue(t.Path).Value<int>());

                    t = t.Next;
                }
            }
        }

        void clearlistBox()
        {
            for (int i = 0; i < listBox1.Items.Count + 1; i++)
            {
                listBox1.Items.RemoveAt(0);
            }
        }

        private void button3_Click(object sender, EventArgs e){
            Print(richTextBox1.Text);

            JToken t = jobj.First;
            for (int i = 0; i < Form1.jobj.Count; i++)
            {

                if (t.Path.Equals(Selected)){
                    //set json value to last!!!
                    jobj.Remove(t.Path);
                    jobj.Add(Selected, last);

                    File.WriteAllText(FileName, JsonConvert.SerializeObject(jobj));

                    clearlistBox();
                    populatelistBox();

                    break;
                }
                t = t.Next;
            }
        }

        private void textBox1_TextChanged(object sender, EventArgs e){
            lotnum = textBox1.Text;
        }

        private void Print(String printedText)
        {
            bpac.DocumentClass doc = new DocumentClass();
            if (doc.Open(template)){
                doc.GetObject("Text").Text = printedText;
                
                doc.StartPrint("", PrintOptionConstants.bpoDefault);
                doc.PrintOut(1, PrintOptionConstants.bpoDefault);

                doc.EndPrint();
                doc.Close();
            }
            else{
                MessageBox.Show("Could not find template File...");
            }

        }
    }
}