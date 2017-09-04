using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using XMLtoAdv;

namespace PlayerLib
{
    class Body : Statement
    {
        public Statement parent;
        List<Statement> statements = new List<Statement>();

        public Body()
        {
        }

        public Body(string code)
        {
            FunctionBuilder fb = new FunctionBuilder();
            fb.BuildTree(code, this);
        }

        public IfStatement GetLastIf()
        {
            return (IfStatement)statements.Last();
        }

        public override void Execute()
        {
            foreach (Statement n in statements)
            {
                n.Execute();
            }
        }

        public void Add(Statement s)
        {
            statements.Add(s);
        }

        public IfStatement Last()
        {
            return (IfStatement)statements.Last<Statement>();
        }

        public override void AcceptEmitter(AsmEmitter asm)
        {
            foreach (Statement s in statements)
            {
                s.AcceptEmitter(asm);
            }
        }

    }

    class Node
    {
        string text;
        public Statement parent;
        public virtual int Eval() { return 0; }
        public virtual void AcceptEmitter(AsmEmitter asm) { }

        public static int GetLhsObj(string lhs)
        {
            int result;
            if (Int32.TryParse(lhs, out result))
            {
                return result;
            }
            else if (lhs.IndexOf(".") != -1)
            {
                Game g = Game.GetInstance();
                string left = lhs.Substring(0, lhs.IndexOf("."));

                if (g.IsVariable(left))
                {
                    try
                    {
                        return g.GetVarVal(left);
                    }
                    catch (Exception ex)
                    {
                        throw new Exception("Unknown var:" + left, ex);
                    }
                }
                else
                {
                    try
                    {
                        return g.GetObjectId(left);
                    }
                    catch (Exception ex)
                    {
                        throw new Exception("Unknown object:" + left, ex);
                    }
                }
            }
            else
            {
                Game g = Game.GetInstance();
                int _id =  g.GetObjectId(lhs);
                if (_id == -1)
                    throw new Exception("Unknown object:" + lhs);
                return _id;

            }
        }

        public static Node ToNode(string rhs)
         {
            Game g = Game.GetInstance();
            rhs = rhs.Trim();
            int result;
            if (Int32.TryParse(rhs, out result))
            {
                return new Constant(result);
            }
            else if (rhs.ToUpper() == "TRUE")
            {
                return new Constant(1);
            }
            else if (rhs.ToUpper() == "FALSE")
            {
                return new Constant(0);
            }
            else if (rhs.IndexOf('"') == 0)
            {
                
                rhs = rhs.Replace("\"", string.Empty);
                return new Constant(g.GetStringId(rhs));
            }
            else if (rhs.IndexOf('.') != -1)
            {
                string left = rhs.Substring(0, rhs.IndexOf('.'));
                string right = rhs.Substring(rhs.IndexOf('.')+1, rhs.Length - rhs.IndexOf('.')-1);
                return new Attr(left, right);
            }
            else if (g.GetObjectId(rhs) != -1)
            {
                return new Constant(g.GetObjectId(rhs));
            }
            else if (g.IsVariable(rhs))
            {
                return new GameVar(rhs);
            }
            else if (rhs.IndexOf("rand(") != -1)
            {
                int inner = rhs.IndexOf('(');
                int close = rhs.IndexOf(')');
                return new RandVar(rhs.Substring(inner+1, close-(inner+1)));
            }
            else
                throw new Exception("Don't know what to do with " + rhs);
        }
    }

    abstract class Statement
    {
        public abstract void Execute();
        public abstract void AcceptEmitter(AsmEmitter asm);


    }

    class SetVariable  : Statement
    {
        int val;
        string varName;
        Node rhs;

        public SetVariable(string var, string val)
        {
            this.varName = var;
          //  this.val = Convert.ToInt16(val);
            rhs = Node.ToNode(val);
        }

        public override void Execute()
        {
            Game g = Game.GetInstance();
            g.SetVar(varName, rhs.Eval());
        }

        public override void AcceptEmitter(AsmEmitter asm)
        {
            rhs.AcceptEmitter(asm);  //push rhs
            asm.WriteSetVar(varName);
        }
    }


    class RandVar : Node
    {
        Node mod;
        
        public RandVar(string val)
        {
            mod = ToNode(val);
        }

        public override int Eval()
        {
            Random r = new Random();
            int m = mod.Eval();
            int x =  r.Next(m);
            return x;
        }

    }

    class AddToVariable : Statement
    {
        Node val;
        string varName;

        public AddToVariable(string var, string val)
        {
            this.varName = var;
            this.val = Node.ToNode(val);
            
        }

        public override void Execute()
        {
            try
            {
                Game g = Game.GetInstance();
                int v = val.Eval();
                g.AddVar(varName, v);
            }
            catch (KeyNotFoundException knf)
            {
                throw new KeyNotFoundException("Unknown variable: " + varName, knf);
            }
        }

        public override void AcceptEmitter(AsmEmitter asm)
        {
            val.AcceptEmitter(asm); //push rhs
            asm.WriteAddToVar(varName);
        }

    }

    class IfStatement : Statement
    {
        public IfStatement(string express, string code)
        {
            expr = ExpressionBuilder.CreateExpr(express);
            body = new Body(code);
            body.parent = this;
        }

        public override void Execute()
        {
            Game g = Game.GetInstance();
            if (expr.Eval())
            {
                g.Debug("condition is true. executing body");
                body.Execute();
            }
            else if (elseNode != null)
            {
                 g.Debug("condition is false. executing else");

                elseNode.Execute();
            }
        }

        public void AddElse()
        {
            elseNode = new Body();
        }

        public override void AcceptEmitter(AsmEmitter asm)
        {
            string label = asm.GetNextLabel();

            
            if (elseNode == null)
            {//just an 'if' statement

                expr.AcceptEmitter(asm);  //leaves result on stack
                asm.WriteJumpOnFalse(label);  //pull it and jump                           
                body.AcceptEmitter(asm);
                asm.WriteLabel(label);
            }
            else if (elseNode != null)
            {
                string outLabel = asm.GetNextLabel();
                asm.WriteJumpOnFalse(label);  //pull it and jump                           
                body.AcceptEmitter(asm);
                asm.WriteJump(outLabel); //jump out
                asm.WriteLabel(label);
                elseNode.AcceptEmitter(asm);
                asm.WriteLabel(outLabel);
            }

        }

        public Expression expr;
        public Body body;
        public Body elseNode;  //else or else if

    }

    class Expression 
    {
        public Node lhs;
        public Node rhs;
        public Opr op;
        public string text;
    
        public bool Eval()
        {
            Game g = Game.GetInstance();
            g.Debug("Evaluating:" + text);

            if (op.opType == Opr.EQ)
                return (lhs.Eval() == rhs.Eval());
            if (op.opType == Opr.NEQ)
                return (lhs.Eval() != rhs.Eval());
            if (op.opType == Opr.GT)
                return (lhs.Eval() > rhs.Eval());
            if (op.opType == Opr.LT)
                return (lhs.Eval() < rhs.Eval());
            if (op.opType == Opr.OR)
                return (lhs.Eval() !=0 || rhs.Eval() !=0 );
            if (op.opType == Opr.AND)
                return (lhs.Eval() != 0 && rhs.Eval() != 0);
            return false;
        }

        public void AcceptEmitter(AsmEmitter asm)
        {
            //write the expression
            lhs.AcceptEmitter(asm);
            rhs.AcceptEmitter(asm);

            //apply operator and leave result on stack
            op.AcceptEmitter(asm);

        }

    }

    class Opr
    {
        public const int EQ=0;
        public const int NEQ = 1;
        public const int GT = 2;
        public const int LT = 3;
        public const int OR = 4;
        public const int AND = 5;
        public  int opType;
        public string txt;

        public Opr(int t)
        {
            opType = t;

            if (opType == EQ)
                txt = "==";
            if (opType == NEQ)
                txt = "!=";
            if (opType == GT)
                txt = ">";
            if (opType == LT)
                txt = "<";
            if (opType == AND)
                txt = "&&";
            if (opType == OR)
                txt = "OR";
        }
        
        public Opr(string t)
        {
            if (t == "==")
                opType = EQ;

            if (t == "!=")
                opType = NEQ;

            if (t == ">")
                opType = GT;

            if (t == "<")
                opType = LT;

            if (t == "&&")
                opType = AND;

            if (t == "||")
                opType = OR;

            txt = t;
        }


        //applies the operator and leaves
        //the result on the stack
        public void AcceptEmitter(AsmEmitter asm)
        {
            if (opType == Opr.EQ)
                asm.WriteEqTest();
            else if (opType == Opr.NEQ)
                asm.WriteNeqTest();
            else if (opType  == Opr.GT)
                asm.WriteGtTest();
            else if (opType == Opr.LT)
                asm.WriteLtTest();
            else if (opType == Opr.AND)
                asm.WriteAndTest();
            else if (opType == Opr.OR)
                asm.WriteOrTest();
        }
    }

    class Constant : Node
    {
        int val;
        public Constant(int v) { val = v; }

        public override  int Eval() 
        {
            Game g = Game.GetInstance();
            g.Debug("Returning constant:" + val);
            return val; 
        }

        public void AcceptEmitter(AsmEmitter asm)
        {
            asm.WriteConstant(val);
        }

    }

    class GameVar : Node
    {
        string name;
        public GameVar(string name) { this.name = name; }

        public override int Eval() 
        {
            try
            {
                Game g = Game.GetInstance();
                return g.GetVarVal(name);
            }
            catch (KeyNotFoundException knf)
            {
                throw new Exception("Variable not found:" + name, knf);
            }
        }
    }
   

   
    //works for properties, too
    class SetAttr : Statement
    {
        string obj;
        string attr;
        Node rhs;

        public SetAttr(string obj, string attr, string rhs)
        {
            this.obj = obj;
            this.attr = attr.ToUpper();

            this.rhs = Node.ToNode(rhs);
        }

        public override void Execute()
        {
            Game g = Game.GetInstance();
            int val = rhs.Eval();
            g.Debug("Setting " + obj + "." + attr + " to " + val );
            
            g.SetObjectAttr(Node.GetLhsObj(obj), attr, val);
        }

        public override void AcceptEmitter(AsmEmitter asm)
        {
            Game g = Game.GetInstance();
            int o = g.GetObjectId(obj);
            asm.WriteConstant(o);

            rhs.AcceptEmitter(asm);  //push value

            asm.WriteSetAttr(attr);
        }
    }


    class Attr : Node
    {
        string lhs;
        string attr;
        int id;


        public Attr(string obj, string attr)
        {
            this.lhs = obj;
            this.attr = attr;
        }

        public override int Eval() {
            try
            {
                Game g = Game.GetInstance();
                return g.GetObjectAttr(GetLhsObj(lhs), attr.ToUpper());
            }
            catch (Exception ex)
            {
                throw new Exception("Error near : " + lhs + "." + attr, ex);
            }
        }
    }
    /*
    class Assignment : Statement
    {

        public Assignment(string lh, string rhs)
        {

        }

        public override void Execute()
        {

        }
    }
    */
    class PrintStatement : Statement
    {
        string msg;

        public PrintStatement(string msg)
        {
            this.msg = msg;
        }

        public override void Execute()
        {
            Game g = Game.GetInstance();
            g.PrintString(msg);
        }

        public override void AcceptEmitter(AsmEmitter asm)
        {
            Game g = Game.GetInstance();
            int strId = g.GetStringId(msg);
            asm.WritePrint(strId, msg);
        }

    }

    class PrintlnStatement : Statement
    {

        string msg;

        public PrintlnStatement(string msg)
        {
            this.msg = msg;
        }

        public override void Execute()
        {
            Game g = Game.GetInstance();
            g.PrintStringCr(msg);
        }


        public override void AcceptEmitter(AsmEmitter asm)
        {
            Game g = Game.GetInstance();
            int strId = g.GetStringId(msg);
            asm.WritePrintLn(strId, msg);
        }

    }


    class LookStatement : Statement
    {
        public override void Execute()
        {
            Game g = Game.GetInstance();
            g.Look();
        }

        public override void AcceptEmitter(AsmEmitter asm)
        {
            asm.WriteLook();
        }
    }

    class MoveStatement : Statement
    {
        public override void Execute()
        {
            Game g = Game.GetInstance();
            g.Move();
        }

        public override void AcceptEmitter(AsmEmitter asm)
        {
            asm.WriteMove();
        }
    }

}
