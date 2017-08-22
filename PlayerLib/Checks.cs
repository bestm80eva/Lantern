using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace PlayerLib
{
    
     

    partial class Game
    {
        delegate bool VerbCheckDlgt();

        List<Tuple<int,string>> checkList = new List<Tuple<int,string>>();
        Dictionary<string, VerbCheckDlgt> checkTable = new Dictionary<string, VerbCheckDlgt>();

        void BuildCheckTable(XmlDocument doc)
        {
            checkTable.Clear();

            //create jump table
            checkTable.Add("check_see_dobj", new VerbCheckDlgt(check_see_dobj));
            checkTable.Add("check_have_dobj", new VerbCheckDlgt(check_have_dobj));
            checkTable.Add("check_have_iobj", new VerbCheckDlgt(check_have_iobj));
            checkTable.Add("check_dobj_portable", new VerbCheckDlgt(check_dobj_portable));
            checkTable.Add("check_dobj_open", new VerbCheckDlgt(check_dobj_open));
            checkTable.Add("check_dobj_opnable", new VerbCheckDlgt(check_dobj_opnable));
            checkTable.Add("check_dobj_supplied", new VerbCheckDlgt(check_dobj_supplied));
            checkTable.Add("check_iobj_supplied", new VerbCheckDlgt(check_iobj_supplied));
            checkTable.Add("check_dobj_unlocked", new VerbCheckDlgt(check_dobj_unlocked));

            XmlNodeList checks = doc.SelectNodes("//project/checks/check");

            foreach (XmlNode c in checks)
            {
                string verb = c.Attributes.GetNamedItem("verb").Value;

                if (verb.IndexOf(",") != -1)
                {//if there are synonyms, get 1st
                    verb = verb.Substring(0, verb.IndexOf(","));
                }

                int verbId = verbMap[verb.ToUpper()];

                if (verbId != -1)
                {
                    string checkName = c.Attributes.GetNamedItem("check").Value;
                    checkList.Add(new Tuple<int,string>(verbId, checkName));
                }


            }

          
        }

        bool check_see_dobj()
        {
            return true; //legacy
        }

        bool check_have_dobj()
        {
            if (!VisibleAncestor(PLAYER,dobj))
            {
                PrintStringCr("YOU DON'T SEE THAT.");
                return false;
            }
            return true;
        }

        bool check_have_iobj()
        {
            if (!VisibleAncestor(PLAYER, iobj))
            {
                PrintStringCr("YOU DON'T SEE THAT.");
                return false;
            }
            return true;
        }

        bool check_dobj_portable()
        {
            if (GetObjectAttr(dobj,"PORTABLE") == 1)
            {
                PrintStringCr("THAT IS FIXED IN PLACE.");
                return false;
            }
            return true;
        }


        bool check_dobj_supplied()
        {
            if (dobj == -1)
            {
                PrintStringCr("LOOK'S LIKE YOU'RE MISSING A NOUN.");
                return false;
            }
            return true;
        }

        bool check_iobj_supplied()
        {
            if (iobj == -1)
            {
                PrintStringCr("LOOK'S LIKE YOU'RE MISSING A NOUN.");
                return false;
            }
            return true;
        }

        bool check_dobj_unlocked()
        {
            if (GetObjectAttr(dobj, "LOCKED") == 1)
            {
                PrintStringCr("THE " + GetObjectName(dobj) + " IS LOCKED.");
                return false;
            }
            return true;
        }

        bool check_iobj_container()
        {
            if (GetObjectAttr(dobj, "CONTAINER") == 0)
            {
                PrintStringCr("THAT'S NOT A CONTAINER.");
                return false;
            }
            return true;
        }

        bool check_player_has_dobj()
        {
            if (!VisibleAncestor(PLAYER, dobj))
            {
                PrintStringCr("YOU DON'T SEE THAT.");
                return false;
            }
            return true;
        }

        bool check_dobj_opnable()
        {
            if (GetObjectAttr(dobj, "OPENABLE") == 0)
            {
                PrintStringCr("THAT'S NOT OPENABLE.");
                return false;
            }
            return true;
        }

        bool check_dobj_open()
        {
            return true;
        }

        bool RunChecks()
        {
            try
            {
                
                foreach (Tuple <int,string> t in checkList)
                {
                    if (t.Item1 == verb)
                    {
                        VerbCheckDlgt chk = checkTable[t.Item2];
                        if (!chk())
                        {
                            return false;
                        }
                    }
                }
            }
            catch (Exception e)
            {
                return true; //verb had no checks
            }
            return true;
        }
    }
}
