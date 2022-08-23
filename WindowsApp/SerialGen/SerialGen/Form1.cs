using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Timer = System.Windows.Forms.Timer;

namespace SerialGen
{

    public partial class Form1 : Form
    {
        public static bool update = false;
        public static JObject jobj;
        public static string FileName = "Items.json";



        //JObject jobj;
        int first = 0;
        int count = 1;
        int last = 0;
        Form2 newProduct;
        Timer timer;

        public Form1()
        {
            InitializeComponent();
        }

        private string Selected = "";

        private void TimerTick(Object myObject,EventArgs myEventArgs) {
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
            last += (count-1);

            if (first >= last)
                last = first;

            label2.Text = first + " -> " + last;

            string str = "";
            for(var i=0; i<count-1; i++){
                str += ((first+1)+i) +" ";
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

        private void button3_Click(object sender, EventArgs e)//Save
        {
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
    }
}