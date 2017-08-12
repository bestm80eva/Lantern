namespace XTAC
{
    partial class TestClient
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.outputWindow = new System.Windows.Forms.TextBox();
            this.inputWindow = new System.Windows.Forms.TextBox();
            this.ReloadBtn = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // outputWindow
            // 
            this.outputWindow.Location = new System.Drawing.Point(1, 3);
            this.outputWindow.Multiline = true;
            this.outputWindow.Name = "outputWindow";
            this.outputWindow.Size = new System.Drawing.Size(434, 228);
            this.outputWindow.TabIndex = 0;
            this.outputWindow.TextChanged += new System.EventHandler(this.outputWindow_TextChanged);
            // 
            // inputWindow
            // 
            this.inputWindow.Location = new System.Drawing.Point(1, 237);
            this.inputWindow.Name = "inputWindow";
            this.inputWindow.Size = new System.Drawing.Size(356, 20);
            this.inputWindow.TabIndex = 1;
            this.inputWindow.TextChanged += new System.EventHandler(this.inputWindow_TextChanged);
            this.inputWindow.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.inputWindow_KeyPress);
            // 
            // ReloadBtn
            // 
            this.ReloadBtn.Location = new System.Drawing.Point(363, 235);
            this.ReloadBtn.Name = "ReloadBtn";
            this.ReloadBtn.Size = new System.Drawing.Size(75, 23);
            this.ReloadBtn.TabIndex = 2;
            this.ReloadBtn.Text = "Reload";
            this.ReloadBtn.UseVisualStyleBackColor = true;
            this.ReloadBtn.Click += new System.EventHandler(this.ReloadBtn_Click);
            // 
            // TestClient
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(441, 261);
            this.Controls.Add(this.ReloadBtn);
            this.Controls.Add(this.inputWindow);
            this.Controls.Add(this.outputWindow);
            this.Name = "TestClient";
            this.Text = "Test Client";
            this.Load += new System.EventHandler(this.TestClient_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox outputWindow;
        private System.Windows.Forms.TextBox inputWindow;
        private System.Windows.Forms.Button ReloadBtn;
    }
}