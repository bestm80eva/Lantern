using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;


namespace XMLtoAdv
{
    public class CodeWriter
    {

        protected StreamWriter sw;
        protected AsmEmitter asm;

        public CodeWriter(AsmEmitter writer, StreamWriter sw)
        {
            this.sw = sw;
            asm = writer;
        }


        public void WriteEqTest(string label)
        {
            asm.WriteEqTest();

        }

        public void WriteNeqTest(string label)
        {
            asm.WriteEqTest();
        }
    
        public void WriteGtTest(string label)
        {
            asm.WriteGtTest();
        }

        public void WriteLtTest(string label)
        {
            asm.WriteLtTest();
        }

        public void WriteAndTest()
        {
        }

        public void WriteOrTest()
        {
        }

    }
}
