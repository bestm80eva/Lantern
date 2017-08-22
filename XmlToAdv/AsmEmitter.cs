using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace XMLtoAdv
{
    public abstract class AsmEmitter
    {
        protected int labelId;
        protected StreamWriter sw;
        protected Dictionary<string, Int32> attrIndexes = new Dictionary<string, int>();
        protected Dictionary<string, string> propBytes = new Dictionary<string, string>();  //which byte to look in
        protected Dictionary<string, string> propBits = new Dictionary<string, string>(); //bit masks

        public AsmEmitter(StreamWriter sw)
        {
            this.sw = sw;
            attrIndexes.Add("id", 0);
            attrIndexes.Add("holder", 1);
            attrIndexes.Add("initial_description", 2);
            attrIndexes.Add("initialdescription", 2);
            attrIndexes.Add("description", 3);
            attrIndexes.Add("n", 4);
            attrIndexes.Add("s", 5);
            attrIndexes.Add("e", 6);
            attrIndexes.Add("w", 7);
            attrIndexes.Add("ne", 8);
            attrIndexes.Add("se", 9);
            attrIndexes.Add("sw", 10);
            attrIndexes.Add("nw", 11);
            attrIndexes.Add("up", 12);
            attrIndexes.Add("down", 13);
            attrIndexes.Add("in", 14);
            attrIndexes.Add("out", 15);
            attrIndexes.Add("mass", 16);

            /* BYTE1
             * SCENERY_MASK equ 1
            SUPPORTER_MASK equ 2
            CONTAINER_MASK equ 4
            TRANSPARENT_MASK equ 8
            OPENABLE_MASK equ 16
            OPEN_MASK equ 32
            LOCKABLE_MASK equ 64
            LOCKED_MASK equ 128
             */

            propBytes.Add("scenery", "PROPERTY_BYTE_1");
            propBytes.Add("supporter", "PROPERTY_BYTE_1");
            propBytes.Add("container", "PROPERTY_BYTE_1");
            propBytes.Add("transparent", "PROPERTY_BYTE_1");
            propBytes.Add("openable", "PROPERTY_BYTE_1");
            propBytes.Add("open", "PROPERTY_BYTE_1");
            propBytes.Add("lockable", "PROPERTY_BYTE_1");
            propBytes.Add("locked", "PROPERTY_BYTE_1");



            /*
            PORTABLE_MASK equ 1
            EDIBLE_MASK equ 2
            DRINKABLE_MASK equ 4
            FLAMMABLE_MASK equ 8
            LIGHTABLE_MASK equ 16
            LIT_MASK equ 32	
            EMITTING_LIGHT_MASK equ 32
            DOOR_MASK equ 64
            UNUSED_MASK equ 128
            */
            propBytes.Add("portable", "PROPERTY_BYTE_2");
            propBytes.Add("backdrop", "PROPERTY_BYTE_2");
            propBytes.Add("wearable", "PROPERTY_BYTE_2");
            propBytes.Add("beingworn", "PROPERTY_BYTE_2");
            propBytes.Add("lightable", "PROPERTY_BYTE_2");
            propBytes.Add("lit", "PROPERTY_BYTE_2");
            propBytes.Add("emittinglight", "PROPERTY_BYTE_2");
            propBytes.Add("door", "PROPERTY_BYTE_2");

            //bit masks

            /*
            SCENERY_MASK equ 1
            SUPPORTER_MASK equ 2
            CONTAINER_MASK equ 4
            TRANSPARENT_MASK equ 8
            OPENABLE_MASK equ 16
            OPEN_MASK equ 32
            LOCKABLE_MASK equ 64
            LOCKED_MASK equ 128
             */

            propBits.Add("scenery", "1");
            propBits.Add("supporter", "2");
            propBits.Add("container", "4");
            propBits.Add("transparent", "8");
            propBits.Add("openable", "16");
            propBits.Add("open", "32");
            propBits.Add("lockable", "64");
            propBits.Add("locked", "128");
            /*
             PORTABLE_MASK equ 1
            EDIBLE_MASK equ 2
            DRINKABLE_MASK equ 4
            FLAMMABLE_MASK equ 8
            LIGHTABLE_MASK equ 16
            LIT_MASK equ 32	
            EMITTING_LIGHT_MASK equ 32
            DOOR_MASK equ 64
            UNUSED_MASK equ 128
             */
            propBits.Add("portable", "1");
            propBits.Add("edible", "2");
            propBits.Add("wearable", "4");
            propBits.Add("beingworn", "8");
            propBits.Add("lightable", "16");
            propBits.Add("lit", "32");
            propBits.Add("emittinglight", "32");
            propBits.Add("door", "64");
            propBits.Add("unused", "128");

        }

        public abstract void WriteEqTest();
        public abstract void WriteLtTest();
        public abstract void WriteGtTest();
        public abstract void WriteNeqTest();
        public abstract void WriteAndTest();
        public abstract void WriteOrTest();
        public abstract void WriteConstant(int val);


        public abstract void WritePrint(int id, string msg);
        public abstract void WritePrintLn(int id, string msg);
        public abstract void WriteLook();
        public abstract void WriteMove();

        //sets attr to var on stack
        public abstract void WriteSetAttr(string attr);
        public abstract void WriteGetAttr(string attr);

        //sets prop to var on stack
        public abstract void WriteSetProp();
        public abstract void WriteLabel(string label);
        public abstract void WriteJump(string label);
        public abstract void WriteJumpOnFalse(string label);

        //sets var to var on stack
        public abstract void WriteSetVar(string varName);
        public abstract void WriteAddToVar(string varName);

        public abstract string GetNextLabel();
    }
}
