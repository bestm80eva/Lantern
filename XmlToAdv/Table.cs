using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace XMLtoAdv
{
    public class Table
    {
        List<String> entries = new List<String>();
        
        public Table()
        {
        }

        public void Clear()
        {
            entries.Clear();
        }

        public void Add(string[] vals)
        {
            foreach (string s in vals)
            {
                AddEntry(s);
            }
        }

        public int  AddEntry(string name)
        {
            if (GetEntryId(name) != -1)
            {//check for dupes
                return GetEntryId(name);
            }
            else
            {
                entries.Add(name);
                return entries.Count; //last index
            }
        }

       
        public int GetEntryId(string name)
        {
            for (int i = 0; i < entries.Count; i++)
            {
                if (entries[i].ToUpper() == name.ToUpper())
                {
                    return i; //basic indexes start at 1
                }
            }

            return -1;
        }

        public string GetEntry(int id)
        {
            return entries[id];
        }

         
        public int GetNumEntries()
        {
            return entries.Count; //don't count dummy entry
        }
       
    }
}
