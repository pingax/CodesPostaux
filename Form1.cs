using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Text.RegularExpressions;
using System.IO;
using NLog;

namespace Outils
{
    public partial class Form1 : Form
    {
        private static Logger logger = LogManager.GetCurrentClassLogger();

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            this.listView1.View = System.Windows.Forms.View.Details;

            ColumnHeader columnheader0 = new ColumnHeader();
            columnheader0.Text = "CP";

            ColumnHeader columnheader1 = new ColumnHeader();
            columnheader1.Text = "Ville";
            columnheader1.Width = 150;
            columnheader1.TextAlign = HorizontalAlignment.Left;

            ColumnHeader col_dept = new ColumnHeader();
            col_dept.Text = "Département";
            col_dept.Width = 300;

            listView1.Columns.Add(columnheader0);
            listView1.Columns.Add(columnheader1);
            listView1.Columns.Add(col_dept);

            this.MaximizeBox = false;
            this.MinimizeBox = false;
            logger.Info("Application lancée");

        }

        
        private void button1_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(textBox1.Text))
            {
                this.listView1.Items.Clear();

                List<string> reslines = new List<string>();
                var lines = File.ReadLines("data\\codespostaux.csv");
                string req = textBox1.Text.Replace("saint", "ST");
                req = req.Replace("Saint", "ST");
                req = req.Replace("é", "e");
                req = req.Replace("è", "e");
                

                //Console.WriteLine(req.ToUpper());

                logger.Error("Récupération des résultats");
                logger.Debug("Récupération des résultats");
                foreach (var line in lines)
                {
                    var res = line.Split(new char[] { ';' }); // CP;VILLE;DEPT
                    string pattern = string.Format(@"^{0}+(.*)+{0}$", req);
                    

                    /* Vérification pour le code postal */
                    if (req.Contains(res[1]))
                    {
                        reslines.Add(string.Format("{0}-{1}-{2}", res[1], res[0], res[2]));
                    }
                    /* verification pour la ville */                    
                    if (res[0].Contains(req.ToUpper()))
                    {
                        reslines.Add(string.Format(@"{0}-{1}-{2}", res[1], res[0], res[2]));
                    }
                    //if (req.ToUpper().Contains(res[0]))
                    //{
                     //   reslines.Add(string.Format(@"{0}-{1}-{2}", res[1], res[0], res[2]));
                   // }
                }

                foreach (var line in reslines)
                {

                    ListViewItem lvi = new ListViewItem(line.Split('-')[0]);
                    lvi.SubItems.Add(line.Split('-')[1]);
                    lvi.SubItems.Add(line.Split('-')[2]);
                    
                    listView1.Items.Add(lvi);

                }
                listView1.Columns[1].AutoResize(ColumnHeaderAutoResizeStyle.ColumnContent);

                
                //this.st_lb_num_reslines.Text = reslines.Count().ToString();
                this.st_txt_res.Text = string.Format(@"{0} résultat{1} trouvé{1} pour votre recherche {2}", reslines.Count().ToString(), reslines.Count() > 1 ? "s" : "", textBox1.Text);
                //this.st_txt_query.Text = "pour votre recherche";
                //this.st_show_req.Text = textBox1.Text;

                //this.st_lb_num_reslines.Text = string.Format(@"{0} résultat{1} pour votre recherche : {2}", reslines.Count(), reslines.Count() > 1 ? "s" : "", this.textBox1.Text);
                statusStrip1.Refresh();

            }
            else
            {
                MessageBox.Show("Veuillez vérifier votre saisie !", "Erreur", MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }


        }

        private void listView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox1_Enter(object sender, EventArgs e)
        {
            this.textBox1.Clear();
        }


    }

}
