using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using XMLtoAdv;

namespace PlayerLib
{
    partial class Game
    {
        void BuildFunctions(XmlDocument doc)
        {
            events.Clear();
            functions.Clear();

            XmlNodeList evts = doc.SelectNodes("//project/events/event");


            foreach (XmlNode n in evts)
            {
                string name="";
                try
                {

                    FunctionBuilder fb = new FunctionBuilder();

                    name = n.Attributes.GetNamedItem("name").Value;
                    string code = n.InnerText;
                    events.Add(fb.CreateRoutine(name, code));
                }
                catch (Exception ex)
                {
                    throw new Exception("Error in function " + name + ":" + ex.Message);
                }
            }

            evts = doc.SelectNodes("//project/routines/routine");

            foreach (XmlNode n in evts)
            {
                FunctionBuilder fb = new FunctionBuilder();

                string name = n.Attributes.GetNamedItem("name").Value;
                string code = n.InnerText;
                functions.Add(name, fb.CreateRoutine(name, code));
            }
        }

        

        
    }
}
