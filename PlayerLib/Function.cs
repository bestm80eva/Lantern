using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PlayerLib
{
    class Function
    {
        public string name;
        public Body body;

        public Body get{
            get {
                return body;
           }
        }

        public Function(string name)
        {
            this.name = name;
            body = new Body();
        }

        public void Execute()
        {
            body.Execute();
        }

    }
}
