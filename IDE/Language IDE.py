# IDE CODE TAMBORDUINE

from cProfile import run
import tkinter as tk
import subprocess
from tkinter.filedialog import askopenfilename, asksaveasfilename

gpath = ''

main = tk.Tk()
main.title("Tambarduine IDE")


class LineNumber(tk.Text):
    def __init__(self, master, text_widget, **kwargs):
        super().__init__(master, **kwargs)
        self.text_widget = text_widget
        self.text_widget.bind('<KeyRelease>', self.on_key_release)
        self.insert(1.0, '1')
        self.configure(state='disabled')

    def on_key_release(self, event=None):
        p, q = self.text_widget.index("@0,0").split('.')
        p = int(p)
        final_index = str(self.text_widget.index(tk.END))
        num_of_lines = final_index.split('.')[0]
        lines = '\n'.join(str(p + no) for no in range(int(num_of_lines) - 1))
        width = len(str(num_of_lines))
        self.configure(state='normal', width=width)
        self.delete(1.0, tk.END)
        self.insert(1.0, lines)
        self.configure(state='disabled')

def open_file():
    global gpath
    path = askopenfilename(filetypes=[('Text Files', '*.txt')])
    if path != '':
        with open(path, 'r') as file:
            code = file.read()
            textEditor.delete('1.0', tk.END)
            textEditor.insert('1.0', code)
            gpath = path
    else:
        print("No file selected")


def save_as():
    global gpath
    if gpath == '':
        path = asksaveasfilename(filetypes=[('Text Files', '*.txt')])
    else:
        path = gpath
    if path != '':
        with open(path, 'w') as file:
            code = textEditor.get('1.0', tk.END)
            file.write(code)
    else:
        print("No file selected")

def compile():
    #global gpath
    #with open(gpath, 'r') as file:
    #code = file.read()
    subprocess.call(["cd", "PanderetaCompiler\Lex Code"])
    return_code = subprocess.call(["lex", "mylexscanner.l"])

def run():
    compile()
    


class ScrollSynch:
    def __init__(self, Editor, LineCounter):
        self.Editor = Editor
        self.LineCounter= LineCounter
    def scrollboth(self, *args):
        self.Editor.yview('moveto',args[0])
        self.LineCounter.yview('moveto',args[0])

textEditor = tk.Text()
textEditor.pack(side=tk.RIGHT, expand=1)

lineText = LineNumber(main, textEditor, width=1)
lineText.pack(side=tk.LEFT)

scroller = ScrollSynch(textEditor, lineText)
textEditor['yscrollcommand'] = scroller.scrollboth

menuBar = tk.Menu(main)

fileBar = tk.Menu(menuBar, tearoff=0)
fileBar.add_command(label='Open', command=open_file)
fileBar.add_command(label='Save', command=save_as)

runBar = tk.Menu(menuBar, tearoff=0)
runBar.add_command(label='Compile', command=compile)
runBar.add_command(label='Compile and Run', command=run)

menuBar.add_cascade(label='File', menu=fileBar)
menuBar.add_cascade(label='Run', menu=runBar)

main.config(menu=menuBar)
main.mainloop()
