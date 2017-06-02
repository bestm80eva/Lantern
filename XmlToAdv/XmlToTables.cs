using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.IO;
using System.Diagnostics;


namespace XMLtoAdv
{
    public class XmlToTables
    {
        protected XmlDocument doc;
        protected Table nameTable = new Table();
        protected Table nogoTable = new Table();
        protected Table descriptionTable = new Table();
        protected Table dict = new Table();
        protected Table verbs = new Table(); //unsplit strings
        protected Table prepTable = new Table();
        protected List<String> routineNames = new List<String>();
        protected Dictionary<string, string> varTable = new Dictionary<string, string>(); //variables
        protected List<UserVar> userVars = new List<UserVar>();
        static protected Dictionary<string,string> skelDirs = new Dictionary<string,string>();

        const string Trs80SkelDir = "trs80Skel";
        public string buildDir;

        //Table strings = new Table(); //for events

        protected List<GameObject> objects = new List<GameObject>();

        protected static string[] asmFlagNames =   { "SCENERY_MASK", "SUPPORTER_MASK", "CONTAINER_MASK", "TRANSPARENT_MASK",
                               "OPENABLE_MASK","OPEN_MASK", "LOCKABLE_MASK", "LOCKED_MASK", 
                               "PORTABLE_MASK", "BACKDROP_MASK", "DRINKABLE_MASK", "FLAMMABLE_MASK", 
                               "LIGHTABLE_MASK", "EMITTING_LIGHT_MASK","DOOR_MASK", "UNUSED_MASK" 
                           };


        protected string[] preps = new string[]
        {            	
	        "IN",
	        "AT",
        	"TO",
        	"INSIDE",
        	"OUT",
        	"UNDER",
        	"ON",
            "OFF",
            "INTO",
            "UP",
            "WITH"
        };


        protected struct UserVar
        {
            public string name;
            public string initialVal;

            public UserVar(string name, string value)
            {
                this.name = name;
                this.initialVal = value;
            }

        }

        static XmlToTables()
        {
            skelDirs["_Z80"] = "trs80Skel";
            skelDirs["_6809"] = "6809Skel";
            skelDirs["_6502"] = "6502Skel";
            skelDirs["_Apple2"] = "6502Skel";
        }


        protected void CreateTables(string fileName, string tgtPlatform)
        {
            doc = new XmlDocument();
            doc.Load(fileName);
            CreateOutputDir(tgtPlatform);
            descriptionTable.Clear();
            descriptionTable.AddEntry("YOU NOTICE NOTHING UNEXPECTED.");
            PopulateNameTable(doc);
            PopulateNogoTable(doc);
            PopulateVerbTable(doc);
            PopulateVariableTable(doc);
            PopulateSubroutineNames(doc);
            ParseForStrings(doc);

        }

        private void PopulateNameTable(XmlDocument doc)
        {
            XmlNodeList list = doc.SelectNodes("//project/objects/object");
            nameTable.Clear();
            objects.Clear();
            descriptionTable.Clear();

            foreach (XmlNode n in list)
            {
                string name = n.Attributes.GetNamedItem("name").Value;
                nameTable.AddEntry(name);

                //get the child node with the description
                XmlNode child = n.ChildNodes[0];
                string desc = child.InnerText;

                //don't add blank descriptions
                if (desc != "")
                {
                    descriptionTable.AddEntry(desc);
                }


                //initial desc
                string initialDesc = n.SelectSingleNode("initialdescription").InnerText;

                if (initialDesc != "" && initialDesc != null)
                {
                    descriptionTable.AddEntry(initialDesc);
                }

                //break the name into words and put each word in the dictionary
                char[] delimiterChars = { ' ' };
                string[] toks = name.Split(delimiterChars);

                foreach (string s in toks)
                {
                    if (s != null && !s.Equals(""))
                    {
                        dict.AddEntry(s);
                    }
                }

                //create the object from the data
                GameObject gobj = new GameObject(n);
                objects.Add(gobj);

                foreach (string s in gobj.synonyms)
                {
                    if (!s.Equals(""))
                        dict.AddEntry(s);
                }

            }

        }

        private void PopulateNogoTable(XmlDocument doc)
        {
            XmlNode list = doc.SelectSingleNode("//project/objects");
            nogoTable.Clear();
            nogoTable.AddEntry("BLANK");
            nogoTable.AddEntry("YOU CAN'T GO THAT WAY.");

            foreach (XmlNode child in list)
            {
                XmlNode msgs = child.SelectSingleNode("nogo");

                if (msgs != null)
                {
                    foreach (XmlNode n in msgs.ChildNodes)
                    {
                        if (!n.InnerText.Equals(""))
                        {
                            string msg = n.InnerText;
                            nogoTable.AddEntry(msg);
                        }
                    }
                }

            }

        }

        void PopulateVariableTable(XmlDocument doc)
        {
            XmlNodeList vars = doc.SelectNodes("//project/variables/builtin/var");
            varTable.Clear();

            foreach (XmlNode n in vars)
            {
                string name = n.Attributes.GetNamedItem("name").Value;
                string addr = n.Attributes.GetNamedItem("addr").Value;
                string val = n.Attributes.GetNamedItem("value").Value;
                varTable[name] = addr;
            }

            userVars.Clear();

            vars = doc.SelectNodes("//project/variables/user/var");

            foreach (XmlNode n in vars)
            {
                string name = n.Attributes.GetNamedItem("name").Value;
                string addr = n.Attributes.GetNamedItem("addr").Value;
                string val = n.Attributes.GetNamedItem("value").Value;
                varTable[name] = name;

                userVars.Add(new UserVar(name, val));
            }
        }

        private void PopulateVerbTable(XmlNode doc)
        {
            verbs.Clear();

            XmlNode biv = doc.SelectSingleNode("//project/verbs/builtinverbs");

            XmlNodeList v = biv.SelectNodes("verb");

            foreach (XmlNode n in v)
            {
                verbs.AddEntry(n.InnerText);
            }

            biv = doc.SelectSingleNode("//project/verbs/userverbs");

            v = biv.SelectNodes("verb");

            foreach (XmlNode n in v)
            {
                verbs.AddEntry(n.InnerText);
            }
        }

        virtual public void Convert() { }

        protected void ParseForStrings(string code)
        {
            try
            {
                int start = code.IndexOf("\"");
                if (start != -1)
                {
                    string rem = code.Substring(start + 1);
                    int end = rem.IndexOf("\"");

                    string substr = rem.Substring(0, end);

                    descriptionTable.AddEntry(substr);
                    string rest = rem.Substring(end + 1);
                    ParseForStrings(rest);
                }
            }
            catch
            {
                throw new Exception("Error in code near: " + code);
            }
        }

        /*
         * Scans for strings in the events and puts them in the description table.
         */
        private void ParseForStrings(XmlDocument doc)
        {
            XmlNodeList events = doc.SelectNodes("//project/events/event");

            foreach (XmlNode n in events)
            {
                string code = n.InnerText;
                ParseForStrings(code);
            }

            events = doc.SelectNodes("//project/routines/routine");

            foreach (XmlNode n in events)
            {
                string code = n.InnerText;
                ParseForStrings(code);
            }
        }

        /*
         * Solves dependency problems
         */
        void PopulateSubroutineNames(XmlDocument doc)
        {
            routineNames.Clear();
            XmlNodeList subs = doc.SelectNodes("//project/routines/routine");

            foreach (XmlNode n in subs)
            {

                string name = n.Attributes.GetNamedItem("name").Value;
                //put name in list
                string fileName = name.Replace(' ', '_');
                routineNames.Add(fileName + "_sub");
            }
        }

        static XmlToTables instance = null;
         
        // string testRoutine = "if (GUARD HUT.holder==5) { print(\"You have the lamp\"); if (WHITE CUBE.description!=1) { print (\"It's open.\"); FLASHLIGHT.holder=offscreen;} }";

        private XmlToTables()
        {
          prepTable.Add(preps);
        }

        public static XmlToTables GetInstance()
        {
            if (instance == null)
            {
                instance = new XmlToTables();
            }

            return instance;
        }
        //ObjectTable objTable = new ObjectTable();

        public void Convert6809(string fileName)
        {
            string oldDir = Environment.CurrentDirectory;

            //get the file path 
            CreateTables(fileName, "_6809");

            WriteWelcomeMessage("Welcome6809.asm", ".strz", "");
            WriteStringTable6809("DescriptionTable6809.asm", "description_table", descriptionTable);
            WriteStringTable6809("Dictionary6809.asm", "dictionary", dict);
            WriteStringTable6809("NogoTable6809.asm", "nogo_table", nogoTable);
            WriteStringTable6809("PrepTable6809.asm", "prep_table", prepTable);
            WriteObjectTable6809("ObjectTable6809.asm");
            WriteObjectWordTable("ObjectWordTable6809.asm", ".db");
            WriteVerbTable("VerbTable6809.asm");
            WriteCheckTable("CheckRules6809.asm", ".db", ".dw");
            WriteSentenceTable("6809", "before",".db", ".dw" );
            WriteSentenceTable("6809", "instead", ".db", ".dw");
            WriteSentenceTable("6809", "after", ".db", ".dw");
            WriteEvents(doc, "6809", new AsmWriter6809());
            WriteUserVarTable(doc, "6809");
            WriteBackdropTable(doc, "BackDropTable6809.asm",".db");

            Environment.CurrentDirectory = oldDir;
        }


        public void ConvertZ80(string fileName)
        {
            string oldDir = Environment.CurrentDirectory;

            //get the file path 
            CreateTables(fileName, "_Z80");

            WriteWelcomeMessage("WelcomeZ80.asm", "DB", ",0h");
            WriteStringTableZ80("StringTableZ80.asm", "string_table", descriptionTable);
            WriteStringTableZ80("DictionaryZ80.asm", "dictionary", dict);
            WriteStringTableZ80("NogoTableZ80.asm", "nogo_table", nogoTable);
            WriteStringTableZ80("PrepTableZ80.asm", "prep_table", prepTable);
            WriteObjectTableZ80("ObjectTableZ80.asm");
            WriteObjectWordTable("ObjectWordTableZ80.asm", "DB");
            WriteVerbTableZ80("VerbTableZ80.asm");
            WriteCheckTable("CheckRulesZ80.asm", "DB", "DW");
            WriteSentenceTable("Z80", "before", "DB", "DW");
            WriteSentenceTable("Z80", "instead", "DB", "DW");
            WriteSentenceTable("Z80", "after", "DB", "DW");
            WriteEvents(doc, "Z80", new AsmWriterZ80());
            WriteUserVarTable(doc, "Z80");
            WriteBackdropTable(doc, "BackDropTableZ80.asm", "DB");

            Environment.CurrentDirectory = oldDir;
        }

      
        

        private void WriteStringTable6809(string fileName, string header, Table t)
        {
            using (StreamWriter sw = File.CreateText(fileName))
            {
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; " + fileName);
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("");
                sw.WriteLine(header);
                for (int i = 0; i < t.GetNumEntries(); i++)
                {
                    if (t.GetEntry(i).Length > 0) //safety check
                    {
                        sw.WriteLine("\t.db " + t.GetEntry(i).Length);
                        sw.WriteLine("\t.strz \"" + t.GetEntry(i) + "\" ; " + i);
                    }
                }
                sw.WriteLine("\t.db 0");

            }

        }

        private void WriteStringTable6502(string fileName, string header, Table t)
        {
            using (StreamWriter sw = File.CreateText(fileName))
            {
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; " + fileName);
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("");
                sw.WriteLine(header);
                for (int i = 0; i < t.GetNumEntries(); i++)
                {
                    if (t.GetEntry(i).Length > 0) //safety check
                    {
                        sw.WriteLine(".byte " + t.GetEntry(i).Length);
                        sw.WriteLine(".text \"" + t.GetEntry(i) + "\" ; " + i);
                        sw.WriteLine(".byte 0 ; null terminator");
                    }
                }
                sw.WriteLine("\t.byte 0");

            }

        }
        private void WriteStringTableZ80(string fileName, string header, Table t)
        {
            using (StreamWriter sw = File.CreateText(fileName))
            {
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; " + fileName);
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("");
                sw.WriteLine(header);
                for (int i = 0; i < t.GetNumEntries(); i++)
                {
                    if (t.GetEntry(i).Length > 0) //safety check
                    {
                        sw.WriteLine("\tDB " + t.GetEntry(i).Length);
                        sw.WriteLine("\tDB \"" + t.GetEntry(i) + "\" ; " + i);
                        sw.WriteLine("\tDB 0 ; null terminator");
                    }
                }
                sw.WriteLine("\tDB 255 ; end of table");

            }

        }

        private void WriteObjectTableZ80(string fileName)
        {
            WriteObjectTable(fileName, "DB","+");
        }

        private void WriteObjectTable6809(string fileName)
        {
            WriteObjectTable(fileName, ".db", "|");
        }

        private void WriteObjectTable6502(string fileName)
        {
            WriteObjectTable(fileName, ".byte", "|");
        }

        //orsym is either | or +
        private void WriteObjectTable(string fileName, string byteSep, string orSym)
        {
            using (StreamWriter sw = File.CreateText(fileName))
            {
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; OBJECT_TABLE");
                sw.WriteLine("; FORMAT: ID,HOLDER,INITIAL DESC,DESC,N,S,E,W,NE,SE,SW,NW,UP,DOWN,OUT,MASS");
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("");
                sw.WriteLine("obj_table");

                foreach (GameObject o in objects)
                {
                    //write the data bytes
                    sw.Write("\t" + byteSep + " ");
                    sw.Write(o.id.ToString() + ",");
                    sw.Write(o.holder.ToString() + ",");

                    int initialDescVal = 255;
                    string initialDesc = o.initialdescription;
                    if (initialDesc != "")
                    {
                        initialDescVal = descriptionTable.GetEntryId(o.initialdescription);
                    }
                    sw.Write(initialDescVal + ",");

                    if (o.description != "")
                    {
                        sw.Write(descriptionTable.GetEntryId(o.description));
                    }
                    else
                    {
                        sw.Write("0"); //no description
                    }

                    for (int i = 0; i < GameObject.NUM_ATTRIBS; i++)
                    {
                        //if attrib is a direction and there is a nogo message, get the id
                        if (o.HasNogoMsg(GameObject.attribNames[i])) // directions
                        {
                            int msgId = nogoTable.GetEntryId(o.GetNogoMsg(GameObject.attribNames[i]));
                            int uId = 256 - msgId;
                            sw.Write("," + uId.ToString());
                        }
                        else
                        {
                            sw.Write("," + o.attribs[i].ToString());
                        }
                    }
                    sw.Write("   ; " + o.name);

                    //write the two bytes with the flags
                    sw.WriteLine("");

                    List<string> flags = new List<string>();

                    //first 8 flags
                    for (int i = 0; i < 8; i++)
                    {
                        bool val = o.GetXmlFlag(GameObject.xmlFlagNames[i]);
                        if (val)
                        {
                            flags.Add(asmFlagNames[i]);
                        }
                    }

                    string flagsStr = "";
                    if (flags.Count == 0) { sw.WriteLine("\t" + byteSep + " 0    ;  flags 1 - 8"); }
                    else
                    {
                        for (int i = 0; i < flags.Count; i++)
                        {
                            if (i != 0) { flagsStr += orSym; }
                            flagsStr += flags[i];
                        }
                        sw.WriteLine("\t" + byteSep + " "  + flagsStr + " ; flags 1-8");
                    }


                    //second 8 flags
                    flags.Clear();

                    for (int i = 8; i < GameObject.xmlFlagNames.Length; i++)
                    {
                        bool val = o.GetXmlFlag(GameObject.xmlFlagNames[i]);
                        if (val)
                        {
                            flags.Add(asmFlagNames[i]);
                        }
                    }

                    flagsStr = "";
                    if (flags.Count == 0) { sw.WriteLine("\t" + byteSep + " 0    ;  flags 9 - 16"); }
                    else
                    {
                        for (int i = 0; i < flags.Count; i++)
                        {
                            if (flagsStr.Length > 0) { flagsStr += orSym; }
                            flagsStr += flags[i];
                        }
                        sw.WriteLine("\t"+ byteSep + " " + flagsStr + " ; flags 9-16");
                    }


                }//end each obj

                sw.WriteLine("\t" + byteSep + " 255  ; end of array indicator");


            }
        }


        private void WriteObjectWordTable(string fileName, string byteDirective=".DB")
        {


            using (StreamWriter sw = File.CreateText(fileName))
            {
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; OBJECT WORD TABLE");
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("");
                sw.WriteLine("obj_word_table");

                char[] delimiterChars = { ' ' }; 

                foreach (GameObject o in objects)
                {
                    sw.Write("\t" + byteDirective + " " + o.id);

                    string name = o.name;

                    string[] toks = name.Split(delimiterChars);
                    int count = toks.Length;

                    int blanks = 3 - count;

                    for (int i = 0; i < count; i++)
                    {
                        //look up the id of each word
                        int wordId = dict.GetEntryId(toks[i]);
                        sw.Write("," + wordId);
                    }

                    //now append the blanks
                    for (int i = 0; i < blanks; i++)
                    {
                        sw.Write(",255");
                    }

                    sw.WriteLine("   ;   " + o.name);
                }//end write objs


                //now write any synonyms
                foreach (GameObject o in objects)
                {
                    if (o.synonyms.Count > 0 && o.synonyms[0] != "")
                    {
                        sw.Write("\t" + byteDirective + " " + o.id);
                        int blanks = 3 - o.synonyms.Count;

                        for (int i = 0; i < o.synonyms.Count; i++)
                        {
                            //look up the id of each word
                            int wordId = dict.GetEntryId(o.synonyms[i]);
                            sw.Write("," + wordId);
                        }

                        //now append the blanks
                        for (int i = 0; i < blanks; i++)
                        {
                            sw.Write(",255");
                        }

                        sw.WriteLine("   ;   synonyms for " + o.name);
                    }//end write synonyms
                }

                sw.WriteLine("\t" + byteDirective + " 255");
//                sw.WriteLine("obj_table_size\t" + byteDirective + " " + objects.Count);
            }
        }

       

        private void WriteVerbTable(string fileName)
        {
            using (StreamWriter sw = File.CreateText(fileName))
            {
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; VerbTable6809.asm ");
                sw.WriteLine("; Machine Generated Verb Table");
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("");

                char[] seps = { ',' };


                for (int i = 0; i < verbs.GetNumEntries(); i++)
                {
                    string verb = verbs.GetEntry(i);
                    string[] toks = verb.Split(seps);
                    string verb_id = toks[0].ToLower().Replace(' ', '_') + "_verb_id";
                    sw.WriteLine(verb_id + " equ " + i);
                }

                sw.WriteLine("");
                sw.WriteLine("");

                sw.WriteLine("verb_table");


                for (int i = 0; i < verbs.GetNumEntries(); i++)
                {
                    string verb = verbs.GetEntry(i);

                    //split it up using commas
                    string[] toks = verb.Split(seps);

                    for (int j = 0; j < toks.Length; j++)
                    {
                        sw.WriteLine("\t.db " + i);
                        sw.WriteLine("\t.db " + toks[j].Length);
                        sw.WriteLine("\t.strz \"" + toks[j].ToUpper() + "\"");
                    }
                }

                sw.WriteLine("\t.db 0,0");
            }
        }


        private void WriteVerbTableZ80(string fileName)
        {
            using (StreamWriter sw = File.CreateText(fileName))
            {
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; VerbTableZ80.asm ");
                sw.WriteLine("; Machine Generated Verb Table");
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("");

                char[] seps = { ',' };


                for (int i = 0; i < verbs.GetNumEntries(); i++)
                {
                    string verb = verbs.GetEntry(i);
                    string[] toks = verb.Split(seps);
                    string verb_id = toks[0].ToLower().Replace(' ', '_') + "_verb_id";
                    sw.WriteLine(verb_id + " equ " + i);
                }

                sw.WriteLine("");
                sw.WriteLine("");

                sw.WriteLine("verb_table");


                for (int i = 0; i < verbs.GetNumEntries(); i++)
                {
                    string verb = verbs.GetEntry(i);

                    //split it up using commas
                    string[] toks = verb.Split(seps);

                    for (int j = 0; j < toks.Length; j++)
                    {
                        sw.WriteLine("\tDB " + i);
                        sw.WriteLine("\tDB " + toks[j].Length);
                        sw.WriteLine("\tDB \"" + toks[j].ToUpper() + "\"");
                        sw.WriteLine("\tDB 0 ; null");
                    }
                }

                sw.WriteLine("\tDB 255");
            }
        }


        private void WriteVerbTable6502(string fileName)
        {
            using (StreamWriter sw = File.CreateText(fileName))
            {
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; VerbTable6502.asm ");
                sw.WriteLine("; Machine Generated Verb Table");
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("");

                char[] seps = { ',' };


                for (int i = 0; i < verbs.GetNumEntries(); i++)
                {
                    string verb = verbs.GetEntry(i);
                    string[] toks = verb.Split(seps);
                    string verb_id = toks[0].ToLower().Replace(' ', '_') + "_verb_id";
                    sw.WriteLine("#define " + verb_id + " " + i);
                }

                sw.WriteLine("");
                sw.WriteLine("");

                sw.WriteLine("verb_table");


                for (int i = 0; i < verbs.GetNumEntries(); i++)
                {
                    string verb = verbs.GetEntry(i);

                    //split it up using commas
                    string[] toks = verb.Split(seps);

                    for (int j = 0; j < toks.Length; j++)
                    {
                        sw.WriteLine(".byte " + i);
                        sw.WriteLine(".byte " + toks[j].Length);
                        sw.WriteLine(".text \"" + toks[j].ToUpper() + "\"");
                        sw.WriteLine(".byte 0 ; null");
                    }
                }

                sw.WriteLine(".byte 255");
            }
        }
        /*Write each event to a separate file,
         * then write out one file that includes all of them
         */
        private void WriteEvents(XmlDocument doc, string processor, AsmWriter asm)
        {
            List<String> eventFiles = new List<string>();
            XmlNodeList events = doc.SelectNodes("//project/events/event");

            foreach (XmlNode n in events)
            {
                //
                string name = n.Attributes.GetNamedItem("name").Value;
                //put name in list
                string fileName = name.Replace(' ', '_');

                eventFiles.Add(fileName + "_event");

               // AsmWriter6809 asm = new AsmWriter6809();
                using (StreamWriter sw = File.CreateText(fileName + "_event_" + processor + ".asm"))
                {
                    asm.WriteRoutine(sw, name + "_event", n.InnerText);
                }
            }

            XmlNodeList subs = doc.SelectNodes("//project/routines/routine");

            foreach (XmlNode n in subs)
            {

                string name = n.Attributes.GetNamedItem("name").Value;
                //put name in list
                string fileName = name.Replace(' ', '_');

                eventFiles.Add(fileName + "_sub");
//                AsmWriter6809 asm = new AsmWriter6809();
                using (StreamWriter sw = File.CreateText(fileName + "_sub_" + processor + ".asm"))
                {
                    asm.WriteRoutine(sw, name + "_sub", n.InnerText);
                }
            }


            //now write out the main include file
            string incFileName = "events6809.asm";
            if (processor.Equals("Z80"))
                incFileName = "EventsZ80.asm";
            else if (processor.Equals("6502"))
                incFileName = "Events6502.asm";

            using (StreamWriter sw = File.CreateText(incFileName))
            {
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; Machine generated include file");
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");

                foreach (string s in eventFiles)
                {
                    if (processor.Equals("6809"))
                        sw.WriteLine("\tinclude " + s + "_6809.asm");
                    else if (processor.Equals("Z80"))
                        sw.WriteLine("*INCLUDE " + s + "_Z80.asm");
                    else if (processor.Equals("6502"))
                        sw.WriteLine(".include \"" + s + "_6502.asm\"");

                }
            }


            //now write out the jumps to the event routines
            using (StreamWriter sw = File.CreateText("event_jumps_" + processor  + ".asm"))
            {
                sw.WriteLine("; jump to machine generated subroutines");

                foreach (string s in eventFiles)
                {
                    if (s.IndexOf("event") != -1)
                    {
                        //sw.WriteLine("\tjsr " + s);
                        asm.WriteCall(sw, s);
                    }
                }


            }

        }
 

        public int GetStringId(string text)
        {
            return descriptionTable.GetEntryId(text);
        }

        public bool IsSubroutine(string name)
        {
            if (name.IndexOf("(") == -1)
            {
                return false;
            }

            string trimmed = name.Substring(0, name.IndexOf("("));
            return routineNames.Contains(trimmed + "_sub");
        }


        public int GetObjectId(string name)
        {
            name = name.Trim().ToUpper();

            //if it's a numeric constant, use that
            int val = -1;
            if (Int32.TryParse(name, out val))
            {
                return val;
            }

            if (name == "") { return 255; }
            if (name == "*") { return 254; }

            foreach (GameObject o in objects)
            {
                if (o.name.ToUpper().Equals(name))
                {
                    return o.id;
                }
            }
            return -1;               
        }

        /*
        private void WriteNogoTable(string fileName)
        {
            using (StreamWriter sw = File.CreateText(fileName))
            {
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; NO GO TABLE");
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("");
                sw.WriteLine("nogo_table");

                for (int i=0; i < nogoTable.GetNumEntries(); i++)
                {
                    sw.WriteLine("\t.db " + nogoTable.GetEntry(i).Length);
                    sw.WriteLine("\t.strz \"" + nogoTable.GetEntry(i) + "\"");
                }
                sw.WriteLine("\t.db 255");
            }
        }
        */
        /*
        private void GameObjectTo6809(GameObject gobj, StreamWriter sw)
        {

        }*/

        /*type should be "before" "instead" or "after"
         */
        private void WriteSentenceTable(string processorType, string type, string byteDef, string wordDef)
        {
            XmlNodeList subs = doc.SelectNodes("//project/sentences/sentence");

            using (StreamWriter sw = File.CreateText(type + "_table_" + processorType + ".asm"))
            {
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; " + type + "_table_" + processorType + ".asm");
                sw.WriteLine("; Machine Generated Sentence Table");
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("");

                if (type.Equals("before"))
                    sw.WriteLine("preactions_table");
                else if (type.Equals("instead"))
                    sw.WriteLine("actions_table");
                else if (type.Equals("after"))
                    sw.WriteLine("postactions_table");
                else
                    throw new Exception("Invalid sentence type.");

                foreach (XmlNode s in subs)
                {
                    string tp = s.Attributes.GetNamedItem("type").Value;

                    if (tp.Equals(type))
                    {
                        string verb = s.Attributes.GetNamedItem("verb").Value;
                        int verbId = GetVerbId(verb);

                        string prep = s.Attributes.GetNamedItem("prep").Value;
                        int prepId = prepTable.GetEntryId(prep);
                        if (prepId == -1)
                        {
                            prepId = 255;
                            // throw new Exception("Unknown prep \"" + prep + "\" in sentence that starts with: " + verb );
                        }

                        string doObj = s.Attributes.GetNamedItem("do").Value;
                        int doId = GetObjectId(doObj);

                        string ioObj = s.Attributes.GetNamedItem("io").Value;
                        int ioId = GetObjectId(ioObj);

                        sw.WriteLine("\t" + byteDef + " " + verbId + "," + doId + "," + prepId + "," + ioId + "\t;" + verb + " " + doObj + " " + prep + " " + ioObj);

                        string subName = s.Attributes.GetNamedItem("sub").Value;
                        subName += "_sub";

                        if (processorType.Equals("6502"))
                            subName = AsmWriter6502.TruncateName(subName);
                        sw.WriteLine("\t" + wordDef + " " + subName);
                    }
                }

                sw.WriteLine("\t" + byteDef + " 255");
                sw.WriteLine("");

            }
        }




        //writes out the check rules
        private void WriteCheckTable(string fileName, string byteSep, string wordSep)
        {
            using (StreamWriter sw = File.CreateText(fileName))
            {

                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; check rules table");
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");

                XmlNodeList checks = doc.SelectNodes("//project/checks/check");
                sw.WriteLine("");
                sw.WriteLine("check_table");

                foreach (XmlNode c in checks)
                {
                    string verb = c.Attributes.GetNamedItem("verb").Value;
                    

                    if (verb.IndexOf(",")!=-1)
                    {//if there are synonyms, get 1st
                        verb = verb.Substring(0, verb.IndexOf(","));
                    }
                    
                    int verbId = GetVerbId(verb);

                    if (verbId != -1)
                    {
                        string subName = c.Attributes.GetNamedItem("check").Value;
                        sw.WriteLine("\t" + byteSep + " " + verbId + " ; " + verb);
                        sw.WriteLine("\t" + wordSep + " " + subName);
                    }
                    else
                    {
                        throw new Exception("Exception while writing check table. Unknown verb: " + verb);
                    }
                }
                sw.WriteLine("\t" + byteSep + " 255");
            }
        }

        void WriteWelcomeMessage(string fileName, string strDelim, string nullByte = "")
        {
            using (StreamWriter sw = File.CreateText(fileName))
            {
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; welcome message include file");
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");

                XmlNodeList list = doc.SelectNodes("//project/welcome");
                sw.WriteLine("");
                sw.WriteLine("welcome " + strDelim + "  \"" + list[0].InnerText + "\"" + nullByte);
                list = doc.SelectNodes("//project/author");
                sw.WriteLine("author " + strDelim + " \"" + list[0].InnerText + "\"" + nullByte);
                list = doc.SelectNodes("//project/version");
                sw.WriteLine("version " + strDelim + " \"" + list[0].InnerText + "\"" + nullByte);
            }
        }

        int GetVerbId(string v)
        {
            char[] seps = { ',' };

            for (int i = 0; i < verbs.GetNumEntries(); i++)
            {
                string s = verbs.GetEntry(i);
                string[] toks = s.Split(seps);

                foreach (string t in toks)
                {
                    if (t.ToUpper().Equals(v.ToUpper()))
                    {
                        return i;
                    }
                }
            }

            return -1;
        }

        public bool IsVar(string s)
        {
            return varTable.Keys.Contains(s);
        }

        int GetObjId(string oname)
        {

            for (int i = 0; i < objects.Count; i++)
            {
                if (objects[i].name.ToUpper().Equals(oname.ToUpper()))
                {
                    return i;
                }
            }

            return -1;
        }


       

        void WriteUserVarTable(XmlDocument doc, string processor)
        {
            using (StreamWriter sw = File.CreateText("UserVars" + processor+ ".asm"))
            {

                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; User variables");
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("");
                string delim = "DB";

                if (processor.Equals("6809"))
                    delim = ".db";
                else if (processor.Equals("6502"))
                    delim = ".byte";

                foreach (UserVar v in userVars)
                {
                   sw.WriteLine(v.name + "\t" + delim +  " " + v.initialVal);
                }

            }
             
        }

        private void WriteBackdropTable(XmlDocument doc, string fileName, string byteSep)
        {
            using (StreamWriter sw = File.CreateText(fileName))
            {

                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("; Machine Generated Backdrop Table ");
                sw.WriteLine("; Format: id, followed by 5 rooms where that object is visible (or 255)");
                sw.WriteLine(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
                sw.WriteLine("");
                sw.WriteLine("backdrop_table");
                for (int i=0; i < objects.Count; i++)
                {
                    GameObject o = objects[i];

                    if (o.IsBackdrop())
                    {
                        sw.Write("\t" +  byteSep + " " + o.id );

                        for (int j=0; j < o.backdropRooms.Length; j++)
                        {
                            sw.Write("," + o.backdropRooms[j]);
                        }
                        sw.WriteLine(" ; " + o.name);
                    }
                }
                sw.WriteLine("\t" + byteSep + " 255");
            }
        }

        public string GetVarAddr(string varName)
        {
            if (varTable.Keys.Contains(varName))
            {
                return varTable[varName];
            }
            else
            {
                throw new Exception("Unknown varibale: " + varName);
            }
        }


        void CreateOutputDir(string tgtPlatform)
        {
            XmlNodeList list = doc.SelectNodes("//project/projname");            
            
            if (list.Count == 0)
            {
                throw new Exception("Project XML does not have a name element!");
            }

            string workingDirectory = list[0].InnerText + tgtPlatform;
            

            if (!Directory.Exists(workingDirectory))
            {
                Directory.CreateDirectory(workingDirectory);
            }

            Environment.CurrentDirectory = workingDirectory;
            buildDir = Environment.CurrentDirectory;
            //copy skeleton into working directory

            string skelDir = skelDirs[tgtPlatform];
            string cmd = "COPY /Y ..\\" + skelDir + "\\*.*  .";
            Process p = Process.Start("cmd", "/c "+cmd);

            //string output = p.StandardOutput.ReadToEnd();
            //MessageBox.Show(output);

            p.WaitForExit();

            //run the build
        }


        public void ConvertApple2(string fileName)
        {
            string oldDir = Environment.CurrentDirectory;

            try
            {
            
                //get the file path 
                CreateTables(fileName, "_Apple2");

                WriteWelcomeMessage("Welcome6502.asm", ".text", "\n.byte 0\n");
                WriteStringTable6502("StringTable6502.asm", "string_table", descriptionTable);
                WriteStringTable6502("Dictionary6502.asm", "dictionary", dict);
                WriteStringTable6502("NogoTable6502.asm", "nogo_table", nogoTable);
                WriteStringTable6502("PrepTable6502.asm", "prep_table", prepTable);
                WriteObjectTable6502("ObjectTable6502.asm");
                WriteObjectWordTable("ObjectWordTable6502.asm", ".byte");
                WriteVerbTable6502("VerbTable6502.asm");
                WriteCheckTable("CheckRules6502.asm", ".byte", ".word");
                WriteSentenceTable("6502", "before", ".byte", ".word");
                WriteSentenceTable("6502", "instead", ".byte", ".word");
                WriteSentenceTable("6502", "after", ".byte", ".word");
                WriteUserVarTable(doc, "6502");           // WriteEvents(doc, "6502", new AsmWriter6809());

                WriteBackdropTable(doc, "BackDropTable6502.asm", ".db");
                WriteEvents(doc, "6502", new AsmWriter6502());
            }
            finally
            {
                Environment.CurrentDirectory = oldDir;
            }

        }
    }//end class
}
