using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace XMLtoAdv
{
    public class Emitter6502 : AsmEmitter
    {
        public Emitter6502(StreamWriter sw) : base(sw)
        {
        }

        public override void WriteEqTest()
        {
            sw.WriteLine("\ttsx ; rhs to x");
            sw.WriteLine("\tpla ; remove it");
            sw.WriteLine("\tpla ; lhs to a");
            sw.WriteLine("\tcmpx ; ");
            //shift result, put it on stack
            sw.WriteLine("\tphp ; ");
            sw.WriteLine("\tpla ; ");
            sw.WriteLine("\tsra ; shift z bit to rightmost pos");
            sw.WriteLine("\tand #1 ; mask off z bit");
            sw.WriteLine("\tpha ; leave result on stack");
        }

        //not tested
        public override  void  WriteLtTest()
        {
            sw.WriteLine("\ttsx ; rhs to x");
            sw.WriteLine("\tpla ; remove it");
            sw.WriteLine("\tpla ; lhs to a");
            sw.WriteLine("\tcmpx ; ");
            //shift result, put it on stack
            sw.WriteLine("\tphp ; ");
            sw.WriteLine("\tpla ; ");
            sw.WriteLine("\tsra ; shift z bit to rightmost pos");
            sw.WriteLine("\tand #1 ; mask off z bit");
            sw.WriteLine("\txor #1 ; flip z bit");
            sw.WriteLine("\tpha ; leave result on stack");
        }

        //not tested
        public override void WriteGtTest()
        {
            //check carry bit = 0  (which means a borrow occured)
            sw.WriteLine("\ttsx ; rhs to x");
            sw.WriteLine("\tpla ; remove it");
            sw.WriteLine("\tpla ; lhs to a");
            sw.WriteLine("\tcmpx ; ");
            //shift result, put it on stack
            sw.WriteLine("\tphp ; ");
            sw.WriteLine("\tpla ; ");
            sw.WriteLine("\tand #1 ; mask off carry bit");
            sw.WriteLine("\txor #1 ; flip z bit");
            sw.WriteLine("\tpha ; leave result on stack");
        }

        public override void WriteNeqTest()
        {
            sw.WriteLine("\ttsx ; rhs to x");
            sw.WriteLine("\tpla ; remove it");
            sw.WriteLine("\tpla ; lhs to a");
            sw.WriteLine("\tcmpx ; ");
            //shift result, put it on stack
            sw.WriteLine("\tphp ; ");
            sw.WriteLine("\tpla ; ");
            sw.WriteLine("\tsra ; shift z bit to rightmost pos");
            sw.WriteLine("\tand #1 ; mask off z bit");
            sw.WriteLine("\txor #1 ; flip z bit");
            sw.WriteLine("\tpha ; leave result on stack");
        }

        public override void WriteAndTest()
        {
            sw.WriteLine("\ttsx ; rhs to x");
            sw.WriteLine("\tpla ; remove it");
            sw.WriteLine("\tpla ; lhs to a");
            sw.WriteLine("\tandx ; ");
            sw.WriteLine("\tpha ; leave result on stack");            
        }

        public override void WriteOrTest()
        {
            sw.WriteLine("\ttsx ; rhs to x");
            sw.WriteLine("\tpla ; remove it");
            sw.WriteLine("\tpla ; lhs to a");
            sw.WriteLine("\torx ; ");
            sw.WriteLine("\tpha ; leave result on stack");
        }



        public override void WriteConstant(int val)
        {
            sw.WriteLine("\txor #" + val + " ; load constant " + val);
            sw.WriteLine("\tpha");
        }

        public virtual void WritePushConstant(StreamWriter sw)
        {
        }

        public override void WritePrint(int strId, string msg)
        {
            //pop rhs
            sw.WriteLine("\tpla ; get string to print");
            sw.WriteLine("\tjsr printstr");
            //call print sub
        }

        public override void WritePrintLn(int strId, string msg)
        {
            //pop rhs
            sw.WriteLine("\tpla ; get string to print");
            sw.WriteLine("\tjsr printstr");
            //call print sub
        }


        public override void WriteLook()
        {
            sw.WriteLine("\tjsr look_sub");
        }

        public override void WriteMove()
        {
            sw.WriteLine("\tjsr move_sub");   
        }



        //sets attr to var on stack
        //to val on stack
        public override void WriteSetAttr(string attr)
        {
               //pull a, a->y
              //pull a, a->x
              //pull a
              //call
            sw.WriteLine("\tpla ; get value" );
            sw.WriteLine("\ttax ; ");   
            sw.WriteLine("\tldy #" + attrIndexes[attr] + " ; " + attr);
            sw.WriteLine("\tpla ; get object");
            sw.WriteLine("\tjsr set_obj_attr");
        }

        public override void WriteGetAttr(string attr)
        {
            sw.WriteLine("\tldy #" + attrIndexes[attr] + " ; " + attr);
            sw.WriteLine("\tpla ; get object");
            sw.WriteLine("\tjsr get_obj_attr");
            sw.WriteLine("\tpha ; leave it on stack");

        }


        public override void WriteAddToVar(string varName)
        {
            sw.WriteLine("\tlda " + varName );
            sw.WriteLine("\ttsx $" + varName);
            sw.WriteLine("\tadx");
            sw.WriteLine("\tsta " + varName);
            sw.WriteLine("\tpla ; remove rhs from stack");
        }


        //sets prop to var on stack
        public override void WriteSetProp()
        {
        }

        //sets var to var on stack
        public override void WriteSetVar(string varName)
        {
            sw.WriteLine("\tpla ; get val off stack ");
            sw.WriteLine("\tsta " + varName + " ; store it");
        }
 

        public override void WriteLabel(string label)
        {
            sw.WriteLine(label + "\tnop");
        }

        public override string GetNextLabel()
        {
            char c = Convert.ToChar(labelId++);
            return "_" + c.ToString().ToLower();
        }

        public override void WriteJump(string label)
        {
            sw.WriteLine("\tjmp " + label);
        }

        public override void WriteJumpOnFalse(string label)
        {
            sw.WriteLine("\tpla ");
            sw.WriteLine("\tcmp #0");
            sw.WriteLine("\tjne " + label);
        }
    }
}
