#IDE CODE TAMBORDUINE

import tkinter as tk
from tkinter.filedialog import askopenfilename, asksaveasfilename
gpath = ''

main = tk.Tk()
main.title("Tambarduine IDE")

def openFile():
    global gpath
    path = askopenfilename(filetypes=[('C Files', '*.h'), ('Lex Files', '*.l')])
    with open(path, 'r') as file:
        code = file.read()
        textEditor.delete('1.0', tk.END)
        textEditor.insert('1.0', code)
        gpath = path

def saveAs():
    global gpath
    if gpath == '':
        path = asksaveasfilename(filetypes=[('C Files', '*.h'), ('Lex Files)', '*.l')])
    else:
        path = gpath
    with open(path, 'w') as file:
        code = textEditor.get('1.0', tk.END)
        file.write(code)
        

textEditor = tk.Text()
textEditor.pack()

menuBar = tk.Menu(main)

fileBar = tk.Menu(menuBar, tearoff = 0)
fileBar.add_command(label='Open', command = openFile)
fileBar.add_command(label='Save', command = saveAs)
fileBar.add_command(label='Exit', command = close)

runBar = tk.Menu(menuBar, tearoff = 0)
runBar.add_command(label='Compile')
runBar.add_command(label='Compile and Run')

menuBar.add_cascade(label='File', menu = fileBar)
menuBar.add_cascade(label='Run', menu = runBar) 

main.config(menu = menuBar)
main.mainloop()
