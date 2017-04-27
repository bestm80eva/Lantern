using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace XTAC
{
    public partial class Form1 : Form
    {

        void AddDefaultFunctions()
        {
            //kill self routine
            Routine r = new Routine();
            r.Name = "kill_self";
            r.Text = "println(\"IF YOU ARE EXPERIENCING SUICIDAL THOUGHTS, YOU SHOULD SEEK PSYCHIATRIC HELP.\");";
            xproject.Project.Routines.Routine.Add(r);

            r = new Routine();
            r.Name = "kill_player";
            r.Text = "println(\"***YOU HAVE DIED***.\");player.holder=1;\n";
            xproject.Project.Routines.Routine.Add(r);

            //kill self routine
            r = new Routine();
            r.Name = "talk_to_self";
            r.Text = "println(\"TALKING TO YOURSELF IS A SIGN OF IMPENDING MENTAL COLLAPSE.\");";
            xproject.Project.Routines.Routine.Add(r);

            //listen
            r = new Routine();
            r.Name = "listen";
            r.Text = "println(\"YOU HEAR NOTHING UNEXPECTED.\");";
            xproject.Project.Routines.Routine.Add(r);

            r = new Routine();
            r.Name = "smell";
            r.Text = "println(\"YOU SMELL NOTHING UNEXPECTED.\");";
            xproject.Project.Routines.Routine.Add(r);


            r = new Routine();
            r.Name = "wait";
            r.Text = "println(\"TIME PASSES...\");";
            xproject.Project.Routines.Routine.Add(r);

            r = new Routine();
            r.Name = "yell";
            r.Text = "println(\"AAAAAAAAAAAAARRRRGGGGGG!\");";
            xproject.Project.Routines.Routine.Add(r);

            r = new Routine();
            r.Name = "jump";
            r.Text = "println(\"WHEEEEEE!\");";
            xproject.Project.Routines.Routine.Add(r);
        }

        void AddDefaultVars()
        {
            //add variables to a newly created project
            builtinVarsListBox.Items.Clear();
            CreateDefaultVar("$dobj", "sentence+1", "0");
            CreateDefaultVar("$iobj", "sentence+3", "0");
            CreateDefaultVar("$score", "score", "0");
            CreateDefaultVar("$moves", "moves", "0");
            CreateDefaultVar("$health", "health", "100");
            CreateDefaultVar("$turnsWithoutLight", "turns_without_light", "100");
            CreateDefaultVar("$gameOver", "gameOver", "0");

        }


        void AddDefaultSentences()
        {
            Sentence s = new Sentence();
            s.Verb = "kill";
            s.Do = "PLAYER";
            s.Io = "";
            s.Prep = "";
            s.Sub = "kill_self";
            s.Type = "instead";
            xproject.Project.Sentences.Sentence.Add(s);

            s = new Sentence();
            s.Verb = "talk to";
            s.Do = "PLAYER";
            s.Io = "";
            s.Prep = "";
            s.Sub = "talk_to_self";
            s.Type = "instead";
            xproject.Project.Sentences.Sentence.Add(s);

            s = new Sentence();
            s.Verb = "listen";
            s.Do = "";
            s.Io = "";
            s.Prep = "";
            s.Sub = "listen";
            s.Type = "instead";
            xproject.Project.Sentences.Sentence.Add(s);

            s = new Sentence();
            s.Verb = "smell";
            s.Do = "";
            s.Io = "";
            s.Prep = "";
            s.Sub = "smell";
            s.Type = "instead";
            xproject.Project.Sentences.Sentence.Add(s);


            s = new Sentence();
            s.Verb = "wait";
            s.Do = "";
            s.Io = "";
            s.Prep = "";
            s.Sub = "wait";
            s.Type = "instead";
            xproject.Project.Sentences.Sentence.Add(s);


            s = new Sentence();
            s.Verb = "yell";
            s.Do = "";
            s.Io = "";
            s.Prep = "";
            s.Sub = "yell";
            s.Type = "instead";
            xproject.Project.Sentences.Sentence.Add(s);

            s = new Sentence();
            s.Verb = "jump";
            s.Do = "";
            s.Io = "";
            s.Prep = "";
            s.Sub = "jump";
            s.Type = "instead";
            xproject.Project.Sentences.Sentence.Add(s);
        }


        void AddDefaultVerbChecks()
        {
            AddCheck("close", "check_dobj_supplied");
            AddCheck("close", "check_see_dobj");
            AddCheck("drink", "check_dobj_supplied");
            AddCheck("drink", "check_see_dobj");
            AddCheck("drink", "check_have_dobj");
            AddCheck("drop", "check_dobj_supplied");
            AddCheck("drop", "check_see_dobj");
            AddCheck("drop", "check_have_dobj");
            AddCheck("eat", "check_dobj_supplied");
            AddCheck("eat", "check_see_dobj");
            AddCheck("enter", "check_dobj_supplied");
            AddCheck("enter", "check_see_dobj");
            AddCheck("examine", "check_dobj_supplied");
            AddCheck("examine", "check_see_dobj");
            AddCheck("get", "check_dobj_supplied");
            AddCheck("get", "check_see_dobj");
            AddCheck("get", "check_dont_have_dobj");
            AddCheck("kill", "check_dobj_supplied");
            AddCheck("kill", "check_see_dobj");
            AddCheck("light", "check_dobj_supplied");
            AddCheck("light", "check_see_dobj");
            AddCheck("light", "check_have_dobj");
            AddCheck("open", "check_dobj_supplied");
            AddCheck("open", "check_see_dobj");
            AddCheck("put", "check_dobj_supplied");
            AddCheck("put", "check_see_dobj");
            AddCheck("put", "check_prep_supplied");
            AddCheck("put", "check_iobj_supplied");
            AddCheck("put", "check_not_self_or_child");
            AddCheck("talk to", "check_dobj_supplied");
            AddCheck("talk to", "check_see_dobj");
            AddCheck("turn on", "check_dobj_supplied");
            AddCheck("turn on", "check_see_dobj");
            AddCheck("turn on", "check_have_dobj");
            AddCheck("unlock", "check_dobj_supplied");
            AddCheck("unlock", "check_see_dobj");
        }

        void AddCheck(string verb, string check)
        {
            Check c = new Check();
            c.Verb = verb;
            c._check = check;
            xproject.Project.Checks.Check.Add(c);
        }

        void AddPrepositions()
        {
            string[] defaultPreps = new string[] { "in", "on", "at", "under", "into", "inside", "through", "out", "behind", "off", "up", "with" };

            xproject.Project.Preps.Prep = new List<string>();
            foreach (string s in defaultPreps) { xproject.Project.Preps.Prep.Add(s); }
        }

        void AddDefaultVerbs()
        {

            string[] defaultVerbs = new string[] { 
                "n,go north,north","s,go south,south","e,go east,east","w,go west,west","ne,go northeast,northeast","se,go southeast,southeast","sw,go southwest,southwest","nw,go northwest,northwest",
"up,go up,u","down,go down,d","enter,go in,go into,go inside","out","get,take,grab,pick up","inventory,i","kill","drop","light","look,l","examine,x,look at","look in,inspect,search","open","lock","unlock","close,shut","eat","drink","put,place","quit","smell,sniff","listen","wait","climb",
"yell,scream,shout", "jump", "talk to", "turn on"
            };

            foreach (string s in defaultVerbs) { xproject.Project.Verbs.Builtinverbs.Verb.Add(s); }
        }


    }
}
