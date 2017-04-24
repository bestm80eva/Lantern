using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace XMLtoAdv
{
    public class GameObject
    {
        public const int SIZE = 19;
        public const int NUM_ATTRIBS = 13;
        public const int NUM_PROPERTIES = 16;
        public const int NUM_BACKDROP_ROOMS = 5;
        private int _id;
        private string _name;
        private string _initial_desc;
        private string _desc ;
        private int _holder;
        private bool _isBackdrop = false;

        Dictionary<string,bool> flagsMap = new Dictionary<string,bool>();
        Dictionary<string, string> nogoMap = new Dictionary<string, string>(); 
        public int[] properties = new int[NUM_PROPERTIES];
        public int[] attribs = new int[NUM_ATTRIBS];
        public int[] backdropRooms = new int[NUM_BACKDROP_ROOMS];

        public static string[] attribNames = { "n", "s", "e", "w", "ne", "se", "sw", "nw", "up", "down", "in", "out", "mass"};  //12

        public static string[] xmlFlagNames = { "scenery", "supporter", "container", "transparent",
                               "openable", "open", "lockable", "locked",
                               "portable", "backdrop", "drinkable", "flammable",
                               "lightable", "emittinglight", "door", "unused"};
        
        public string name {
            get { return _name; }
        }

        public int id { get { return _id; } }
        public int holder { get { return _holder; } }
        public string initialdescription { get { return _initial_desc; } } 
        public string description { get { return _desc; } }
        public List<string> synonyms = new List<String>();
        public bool IsBackdrop() { return _isBackdrop;  }

        public GameObject(XmlNode data)
        {
            _name = data.Attributes.GetNamedItem("name").Value;
            _id = Convert.ToInt32(data.Attributes.GetNamedItem("id").Value);
            _desc = data.SelectSingleNode("description").InnerText;
            _initial_desc = data.SelectSingleNode("initialdescription").InnerText;
            _holder = Convert.ToInt32(data.Attributes.GetNamedItem("holder").Value);

            for (int i = 0; i < NUM_BACKDROP_ROOMS; i++ )
            {
                backdropRooms[i] = 255;       
            }


            LoadBackdrop(data);
            LoadAttribs(data);
            LoadFlags(data);
            LoadNogoMsgs(data);
            LoadSynonyms(data);

        }

        private void LoadBackdrop(XmlNode data)
        {
            XmlNode bd = data.SelectSingleNode("backdrop");
            if (bd != null)
            {
                
                if ( bd.Attributes.GetNamedItem("rooms") != null)
                {  
                    string roomStr = bd.Attributes["rooms"].Value;

                    if (!roomStr.Equals(""))
                    {
                        _isBackdrop = true;
                        properties[9] = 1;  //backdrop property

                        string[] rooms = roomStr.Split(',');

                        for (int i = 0; i < rooms.Length; i++)
                        {
                            backdropRooms[i] = Convert.ToInt32(rooms[i].Trim());
                        }
                    }
                }
                
            }
            
        }

        private void LoadSynonyms(XmlNode data)
        {
            XmlNode syns = data.SelectSingleNode("synonyms");
            if (syns != null)
            {
                XmlNode node = syns.Attributes.GetNamedItem("names");
                if (node != null)
                {
                    string names = node.Value;
                    char[] seps = { ',' };
                    string[] toks = names.Split(seps);

                    foreach (var item in toks)
                    {
                        synonyms.Add(item);
                    }
                }
            }


        }


        private void LoadFlags(XmlNode data)
        {

            XmlNode flagsNode = data.SelectSingleNode("flags");
            for (int i=0; i < xmlFlagNames.Length; i++)
            {
                bool yesNo = false;
                string val = flagsNode.Attributes.GetNamedItem(xmlFlagNames[i]).Value;
                if (val == "1") { yesNo = true; }
                flagsMap.Add(xmlFlagNames[i], yesNo);
            }
        }

        private void LoadAttribs(XmlNode data)
        {
            XmlNode dirs = data.SelectSingleNode("directions");

            for (int i=0; i < NUM_ATTRIBS; i++)
            {
                 string roomStr = dirs.Attributes.GetNamedItem(attribNames[i]).Value;
                 int roomNum = Convert.ToInt32(roomStr);
                 attribs[i] = roomNum;
            }
        }

        private void LoadNogoMsgs(XmlNode data)
        {
            XmlNode nogos = data.SelectSingleNode("nogo");
            if (nogos != null)
            {
                for (int i = 0; i < 10; i++ )
                {
                    string dir = attribNames[i];
                    XmlNode n = nogos.SelectSingleNode(dir);
                    if (n!=null)
                    {
                        nogoMap.Add(dir, n.InnerText);
                    }
                }
            }
        }

        public bool HasNogoMsg(string dir)
        {
            string val = "";
            if (!nogoMap.TryGetValue(dir, out val))
            {
                return false;
            }

            return (!val.Trim().Equals(""));
            
        }


        public string GetNogoMsg(string dir)
        {
            return nogoMap[dir];
        }

        public bool GetXmlFlag(string xmlName)
        {
            try
            {
                return flagsMap[xmlName];
            }
            catch (Exception e)
            {
                return false;
            }
        }

    }
}
