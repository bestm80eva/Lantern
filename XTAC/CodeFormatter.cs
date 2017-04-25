using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace XTAC
{
    class CodeFormatter
    {

        const int numSpaces = 5;
         

        
        public static string Format(string s)
        {

            int indentLevel = 0;
            int index = 0;

            StringBuilder code = new StringBuilder(s);
            while (index != code.Length)
            {
                if (code[index] == '{')
                {
                    //need to delete which space behind {
                    DeleteTrailing(code, ref index);
                    code.Insert(index, '\n');
                    code.Insert(index, '\r');
                    index += 2;
                    FormatLine(code, ref index, indentLevel);
                    indentLevel++;
                    code.Insert(index + 1, '\n');
                    code.Insert(index+1, '\r');
                    index += 3;
                    FormatLine(code, ref index, indentLevel);
                }
                else if (code[index] == '}')
                {
                    //back up
                    
                    code.Remove(index - numSpaces, numSpaces);
                    index -= numSpaces;
                    code.Insert(index + 1, '\n');
                    code.Insert(index + 1, '\r');
                    index += 3;
                    indentLevel--;
                    FormatLine(code, ref index, indentLevel);
                }
                else if (code[index] == ';')
                {
                    index++;
                    code.Insert(index, '\n');
                    code.Insert(index, '\r');
                    index += 2;
                    FormatLine(code, ref index, indentLevel);
                }
                else
                {
                    index++;
                }
            }
            return code.ToString();
        }
         
        public static void FormatLine(StringBuilder codeStr, ref int index, int indentLevel)
        {

            if (index == codeStr.Length) { return; }

            //strip existing space off
            while (IsWhiteSpace(codeStr[index])) 
            {
                codeStr.Remove(index,1);
                if (index == codeStr.Length) { return; }
            }


            if (indentLevel > 0)
            {
                //add the correct amount back
                for (int i = 0; i < indentLevel * numSpaces; i++) { codeStr.Insert(index, ' '); index++; }
                //now look ah
            }
        }

        //assumes index is pointing to a '{'
        //at the end, the index should still point to a '{'
        private static void DeleteTrailing(StringBuilder code, ref int index)
        {
            while (IsWhiteSpace(code[index - 1]))
            {
                code.Remove(index - 1, 1);
                index--;
            }
            
        }

        static bool IsWhiteSpace(char ch)
        {
            if (ch == ' ') return true;
            if (ch == '\r') return true;
            if (ch == '\n') return true;
            if (ch == '\t') return true;
            return false;
        }
    }
}
