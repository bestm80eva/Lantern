using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace XMLtoAdv
{
    class AsmWriter6502 : AsmWriter
    {

        public override void WriteRoutine(StreamWriter sw, string name, string code)
        {

            name = TruncateName(name);
            labelId = 65;
            sw.WriteLine("");
            sw.WriteLine("; machine generate routine from XML file");
            sw.WriteLine("\t.module " +name);
            sw.WriteLine(name);
            sw.WriteLine("\tpha");
            sw.WriteLine("\ttxa");
            sw.WriteLine("\tpha");
            sw.WriteLine("\ttya");
            sw.WriteLine("\tpha");
            code = code.Replace("\r", "");
            code = code.Replace("\n", "");
            code = code.Replace("\t", "");
            WriteCode(code, sw);
            sw.WriteLine("\tpla");
            sw.WriteLine("\ttax");
            sw.WriteLine("\tpla");
            sw.WriteLine("\ttya");
            sw.WriteLine("\tpla");
            sw.WriteLine("\trts");
            sw.WriteLine("");
        }

        protected override void WritePrintStatement(StreamWriter sw, string statement)
        {
            int start = statement.IndexOf("\"");
            string rem = statement.Substring(start + 1);
            int end = rem.IndexOf("\"");
            string text = rem.Substring(0, end);

            sw.WriteLine("\tpha ; print " + text);
            sw.WriteLine("\tlda #$string_table%256");
            sw.WriteLine("\tsta $strAddr");
            sw.WriteLine("\tlda #$string_table/256");
            sw.WriteLine("\tsta $strAddr+1");
            sw.WriteLine("\tlda #" + project.GetStringId(text) + " ; " + text);
            sw.WriteLine("\tjsr printix");
            sw.WriteLine("\tpla ; end print");
        }

        protected override string GetNextLabel()
        {
            char c = Convert.ToChar(labelId++);
            return "_" + c.ToString().ToLower();
        }

        protected override void WriteJump(StreamWriter sw, string label)
        {
            sw.WriteLine("\tjmp " + label);
        }

        public override void WriteCall(StreamWriter sw, string label)
        {
            sw.WriteLine("\tjsr " + label);
        }

        protected override void WriteSubroutineCall(StreamWriter sw, string label)
        {
            string sub = TruncateName(label + "_sub");
            sw.WriteLine("\tjsr " + sub);
        }

        protected override void WriteLookStatement(StreamWriter sw)
        {
            sw.WriteLine("\tjsr look_sub");
        }

        protected override void WritePrintNewline(StreamWriter sw)
        {
            sw.WriteLine("\tjsr printcr");
        }

        protected override void WritePropTest(StreamWriter sw, string code, string objName, string propName, string op, int val, string label)
        {
        }

        protected override void WriteVarTest(StreamWriter sw, string code, string varName, string op, string val, string label)
        {
        }

        protected override void WriteAttrTest(StreamWriter sw, string code, string objName, string attrName, int attrNum, string op, string val, string label)
        {
        }

        protected override void WriteAttrAssignment(StreamWriter sw, string lhs, string rhs)
        {
        }



        protected override void WritePropAssignment(StreamWriter sw, int objId, string obj, string propName, int val)
        {
            if (!propBytes.ContainsKey(propName))
            {
                throw new Exception("Invalid property:" + propName);
            }
        }

        protected override void WriteSetVar(StreamWriter sw, string code)
        {
            string varName, val;
            GetVarAndVal(code, out varName, out val);

            //write the code to set the var
            sw.WriteLine("\tpha");
            sw.WriteLine("\tlda #" + val + " ; load new val");
            sw.WriteLine("\tsta " + varName + " ; store it back");
            sw.WriteLine("\tpla");
        }

        protected override void WriteAddVar(StreamWriter sw, string code)
        {
            string varName, val;
            GetVarAndVal(code, out varName, out val);

            //write the code to set the var
            sw.WriteLine("\tpha");
            sw.WriteLine("\tlda " + varName);
            sw.WriteLine("\tclc");
            sw.WriteLine("\tadc #" + val.Trim());
            sw.WriteLine("\tsta " + varName + " ; store it back");
            sw.WriteLine("\tpla");

        }

        protected override void WriteMoveStatement(StreamWriter sw)
        {
            sw.WriteLine("\tjsr move_player");
        }

        public static string TruncateName(string name)
        {
           if (name.Length < 20)
           {
               return name;
           }
            return name.Substring(0,20);
        }

    }
}
