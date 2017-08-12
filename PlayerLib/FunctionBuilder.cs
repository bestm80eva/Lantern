using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace PlayerLib
{
    class FunctionBuilder
    {

        Function f;
        Game game;
 

        public Function CreateRoutine(string name, string code)
        {
            game = Game.GetInstance();

            Function f = new Function(name);

            try
            {
                BuildTree(code, f.body);
            }
            catch (Exception ex)
            {
                throw new Exception("Error writing function : " + name, ex);
            }

            return f;
        }

          

        public void BuildTree(string code, Body parent)
        {
            try
            {

                code = code.Trim();
                if (code.Length > 0 && code != "}")
                {

                    //does it start with an 'if' statement
                    

                    if (code.IndexOf("if") == 0)
                    {
                        int start = code.IndexOf("(");
                        int end = code.IndexOf(")");
                        string expr = code.Substring(start, (end - start) + 1);

                        //find the matching }
                        string remainder = code.Substring(code.IndexOf("{"));

                        int closingBrace = findClosingBrace(remainder);
                        string inside = remainder.Substring(1, closingBrace - 1).Trim();
                        string outside = remainder.Substring(closingBrace + 1).Trim();  //the next block or statements

                        IfStatement ifStmt = new IfStatement(expr, inside);
                        parent.Add(ifStmt);

                        if (PeekAheadForElse(outside))
                        {
                            ifStmt.AddElse();
                            BuildTree(outside, ifStmt.elseNode);
                        }
                        else
                           BuildTree(outside, parent);
                    }
                    else if (code.IndexOf("else") == 0)
                    {
                        string inner = code.Substring(4).Trim(); //strip off 'else'
                        inner = UnWrapCurlyBraces(inner).Trim();

                        BuildTree(inner, parent);
                    }
                    else
                    {//must just be statements

                        //first part must be a set attr
                        //chop it off, then parse t he rest
                        if (code.IndexOf(";") == -1)
                            throw new Exception("Missing ; near " + code);

                        string statement = code.Substring(0, code.IndexOf(";"));
                         
                        //what kind of statement is it?
                        //if there's a += or -=
                        //if there's a '=' and a '.' then it's an object attr or prop assignment
                        //if there's a '=' and no '.' then its a variable assignment
                        //if there's a "print", then it's a print statement

                        if (statement.IndexOf("printl") != -1)
                        {
                            int start = statement.IndexOf('"');
                            int innerLen = statement.LastIndexOf('"') - statement.IndexOf('\"');
                            string msg = statement.Substring(start, innerLen);
                            PrintlnStatement ps = new PrintlnStatement(msg);
                            parent.Add(ps);
                        }
                        else if (statement.IndexOf("print") != -1)
                        {
                            int start = statement.IndexOf('"');
                            int innerLen = statement.LastIndexOf('"') - statement.IndexOf('\"');
                            string msg = statement.Substring(start, innerLen);
                            PrintStatement ps = new PrintStatement(msg);
                            parent.Add(ps);
                        }
                        else if (statement.IndexOf("look()") != -1)
                        {
                            LookStatement ls = new LookStatement();
                            parent.Add(ls);
                        }
                        else if (statement.IndexOf("move()") != -1)
                        {
                            MoveStatement ms = new MoveStatement();
                            parent.Add(ms);
                        }
                        else if (statement.IndexOf("add(") != -1)
                        {
                            string varName, val;
                            GetVarAndVal2(statement, out varName, out val);
                            AddToVariable av = new AddToVariable(varName,val);
                            parent.Add(av);
                        }
                        else if (statement.IndexOf("set(") != -1)
                        {
                            string varName, val;
                            GetVarAndVal2(statement, out varName, out val);
                            SetVariable sv = new SetVariable(varName,val);
                            parent.Add(sv);
                        }
                        else if (statement.IndexOf("call") == 0)
                        {
                           // statement = statement.Substring(4).Trim(); //chop off "call"
                           // if (XmlToTables.GetInstance().IsSubroutine(statement))
                           // {
                           //     string subName = statement.Substring(0, statement.IndexOf("("));
                           //     WriteSubroutineCall(sw, subName);
                           // }
                           // else throw new Exception("Invalid subroutine name near " + statement);
                        }
                        else if (statement.IndexOf(".") != -1)
                        { //attribute or property assignment
                            string right = statement.Substring(statement.IndexOf("=") + 1, statement.Length - statement.IndexOf("=") - 1).Trim();
                            string attr = statement.Substring(statement.IndexOf(".") + 1, statement.IndexOf("=") - statement.IndexOf(".") - 1).Trim();
                            string obj = statement.Substring(0, statement.IndexOf("."));
                             
                            //convert right to an id;
                            SetAttr assn = new SetAttr(obj, attr, right);
                            parent.Add(assn);
 
                        }//end attr or prop assignment (dot found)
                        else
                        {//var assignment not using set()
                            //                        throw new Exception("Need to Implement var setting");
                            //                      WriteAttrAssignment(statement, obj, right);
                            //if (sw != null)
                            //    sw.WriteLine("\tnop ; this code hasn't been tested.");
                            string right = statement.Substring(statement.IndexOf("=") + 1, statement.Length - statement.IndexOf("=") - 1).Trim();
                            string left = statement.Substring(0, statement.IndexOf("=")).Trim();
                            
                            SetVariable setAttr = new  SetVariable(left, right);
                            parent.Add(setAttr);
                        }

                        string remainder = code.Substring(code.IndexOf(";") + 1).Trim();
                        BuildTree(remainder, parent);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error near code: " + code, ex);
            }
        }

         
        protected void GetVarAndVal2(string code, out string varName, out string val)
        {
            string trimmed = code.Substring(code.IndexOf("(") + 1);
            trimmed = trimmed.Substring(0, trimmed.Length - 1);
            int commaIx = trimmed.IndexOf(',');
            varName = trimmed.Substring(0, commaIx).Trim();
            int close = trimmed.IndexOf(')');
            val = trimmed.Substring(commaIx + 1, trimmed.Length-(commaIx+1));
        }

        //the starting { has NOT been chopped off
        protected int findClosingBrace(string code)
        {
            int count = 0;
            for (int i = 0; i < code.Length; i++)
            {
                if (code[i] == '{') count++;

                if (code[i] == '}')
                {
                    count--;
                    if (count == 0) { return i; }

                }

            }
            return -1;
        }


        protected int ToBit(string val)
        {
            val = val.Trim();
            if (val == "0" || val.ToUpper().Equals("FALSE")) { return 0; }
            return 1;
        }

        protected string UnWrapCurlyBraces(string code)
        {
            if (code[0] == '{')
            {
                int end = code.LastIndexOf("}");
                int start = code.IndexOf("{");
                string unwrapped = code.Substring(start + 1, end - start - 1);
                return unwrapped;
            }
            else return code;
        }

        protected bool PeekAheadForElse(string code)
        {
            return (code.IndexOf("else") == 0);
        }
    }
    
}
